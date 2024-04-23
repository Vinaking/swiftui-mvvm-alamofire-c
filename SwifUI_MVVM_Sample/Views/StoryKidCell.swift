//
//  StoryKidCell.swift
//  SwifUI_MVVM_Sample
//
//  Created by Tùng on 23/04/2024.
//

import SwiftUI

struct StoryKidCell: View {
    var storyKid: StoryKid
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0, content: {
            Text(html: storyKid.text)
                .foregroundStyle(.primary)
            Text(storyKid.by)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        })
    }
}

#Preview {
    StoryKidCell(storyKid: StoryKid(
        id: 1,
        by: "Vinaking",
        parent: 1,
        text: "See also <a href=\"https:&#x2F;&#x2F;ai.meta.com&#x2F;blog&#x2F;meta-llama-3&#x2F;\" rel=\"nofollow\">https:&#x2F;&#x2F;ai.meta.com&#x2F;blog&#x2F;meta-llama-3&#x2F;</a><p>and <a href=\"https:&#x2F;&#x2F;about.fb.com&#x2F;news&#x2F;2024&#x2F;04&#x2F;meta-ai-assistant-built-with-llama-3&#x2F;\" rel=\"nofollow\">https:&#x2F;&#x2F;about.fb.com&#x2F;news&#x2F;2024&#x2F;04&#x2F;meta-ai-assistant-built-wi...</a><p>edit: and <a href=\"https:&#x2F;&#x2F;twitter.com&#x2F;karpathy&#x2F;status&#x2F;1781028605709234613\" rel=\"nofollow\">https:&#x2F;&#x2F;twitter.com&#x2F;karpathy&#x2F;status&#x2F;1781028605709234613</a>",
        time: 11223,
        type: "comment"))
}
