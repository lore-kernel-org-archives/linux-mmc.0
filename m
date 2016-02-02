From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] mmc-utils: Merge the lsmmc tool into mmc-utils
Date: Tue, 2 Feb 2016 22:39:21 +0100
Message-ID: <CACRpkdadeOgJfPXvpLyVZctSqjY7EdW1=TQmetBsQN=GDr7J3Q@mail.gmail.com>
References: <d59ece1ff066b7fd7c8b538a560f726751fb1f9a.1454401105.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:33327 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbcBBVjW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Feb 2016 16:39:22 -0500
Received: by mail-ob0-f179.google.com with SMTP id is5so2578021obc.0
        for <linux-mmc@vger.kernel.org>; Tue, 02 Feb 2016 13:39:21 -0800 (PST)
In-Reply-To: <d59ece1ff066b7fd7c8b538a560f726751fb1f9a.1454401105.git.baolin.wang@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Chris Ball <chris@printf.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, Sebastian Rasmussen <sebras@gmail.com>

On Tue, Feb 2, 2016 at 9:21 AM, Baolin Wang <baolin.wang@linaro.org> wrote:

> The lsmmc tools contains an extensive parser of the CID, CSD, SCR, EXT_CSD
> registers from userspace. The utility works as-is and uses sysfs to read
> the register values.
>
> The original code is created by Sebastian Rasmussen and still lives in
> private git. It need to be merged into mmc-utils repository, which is
> convenient for testing MMC device from userspace.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Nitpicky formalia:

The SoB-chain should represent the delivery path of the code, so I think
it should be:

Signed-off-by: Sebastian Rasmussen <sebras@gmail.com>
Signed-off-by: Chris Ball <chris@printf.net>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

..and then when Ulf merges it it get his SoB too.

Then the Author: has no strong rule by usually should
represent who wrote the majority of the code, so unless you've changes
more than 50% of the code, consider
git commit --amend --author="Sebastian Rasmussen <sebras@gmail.com>"
for this commit.

I usually don't care a lot about the latter but since it's a big and initial
commit I think it matters. If it's too diverse authors and unclear
contributor distribution, a mailing list can be used as author, c.f.
commit a8c21a5451d831e67b7a6fb910f9ca8bc7b43554

Thanks for working on this!

Yours,
Linus Walleij
