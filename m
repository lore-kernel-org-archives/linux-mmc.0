From: Sebastian Rasmussen <sebras@gmail.com>
Subject: Re: [PATCH v2] mmc-utils: Merge the lsmmc tool into mmc-utils
Date: Fri, 5 Feb 2016 16:17:05 +0100
Message-ID: <CAAgDR1MUE6VB65+CtFVH3ydDzwjHx2nitr=Bi4q0JEzVfO=1EQ@mail.gmail.com>
References: <32aeb1c8c24a29aabe3f58bcdf60faf7a39c6491.1454660477.git.baolin.wang@linaro.org>
	<CACRpkdZjJ1nOmFcznXx-RXVcwKgbp0rhPSy85cyui5_2x8X4zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:35033 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbcBEPRH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Feb 2016 10:17:07 -0500
Received: by mail-vk0-f68.google.com with SMTP id e185so2583557vkb.2
        for <linux-mmc@vger.kernel.org>; Fri, 05 Feb 2016 07:17:05 -0800 (PST)
In-Reply-To: <CACRpkdZjJ1nOmFcznXx-RXVcwKgbp0rhPSy85cyui5_2x8X4zw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Baolin Wang <baolin.wang@linaro.org>, Chris Ball <chris@printf.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>

>> From: Sebastian Rasmussen <sebras@gmail.com>
>>
>> The lsmmc tools contains an extensive parser of the CID, CSD, SCR, EXT_CSD
>> registers from userspace. The utility works as-is and uses sysfs to read
>> the register values.
>>
>> The original code is created by Sebastian Rasmussen and still lives in
>> an attachment in the mail archive of linux-mmc. It need to be merged into
>> mmc-utils repository, which is convenient for testing MMC device from userspace.
>>
>> Signed-off-by: Sebastian Rasmussen <sebras@gmail.com>
>> Signed-off-by: Chris Ball <chris@printf.net>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Sebastian Rasmussen <sebras@gmail.com>

I'm not sure I need to do this, maybe it is implicit because of the previous
Signed-off-by in my name. Anyway, thanks Baolin for addressing my
concerns really quickly! :)

 / Sebastian
