From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH] mmc: block: Init sysfs attr to fix lockdep warnings
Date: Thu, 2 Feb 2012 08:31:37 +0900
Message-ID: <CAKYAXd-=9k_n=b1RaE1yCqywx2efo3MWhLJ+VGfOJtijgrSgOw@mail.gmail.com>
References: <1328110316-7593-1-git-send-email-ulf.hansson@stericsson.com>
	<CACRpkdZ5f3rBOkAW-UsrnfjWYkPPVvb3pJCuJiozL7Jso2RCrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43703 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613Ab2BAXbj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2012 18:31:39 -0500
Received: by bkcjm19 with SMTP id jm19so1525999bkc.19
        for <linux-mmc@vger.kernel.org>; Wed, 01 Feb 2012 15:31:38 -0800 (PST)
In-Reply-To: <CACRpkdZ5f3rBOkAW-UsrnfjWYkPPVvb3pJCuJiozL7Jso2RCrg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Rabin Vincent <rabin.vincent@stericsson.com>, stable@kernel.org

2012/2/2 Linus Walleij <linus.walleij@linaro.org>:
> On Wed, Feb 1, 2012 at 4:31 PM, Ulf Hansson <ulf.hansson@stericsson.c=
om> wrote:
>
>> From: Rabin Vincent <rabin.vincent@stericsson.com>
>>
>> Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
>> Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
>> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>

Looks good to me!
Thanks.
>
> This looks like it should go into stable, Chris will you add
> Cc: stable@kernel.org to this if/when you apply it?
>
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
