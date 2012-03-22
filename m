From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: fix card block compile warnings
Date: Thu, 22 Mar 2012 19:02:56 +0100
Message-ID: <CACRpkda7icH2E+394Aj0tkAoZG+2xMUOnd1KxnO=4Xz6TtvQEQ@mail.gmail.com>
References: <1332401709-25513-1-git-send-email-linus.walleij@linaro.org>
	<4F6B05BB.3080109@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33266 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440Ab2CVSC4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Mar 2012 14:02:56 -0400
Received: by ghrr11 with SMTP id r11so2015172ghr.19
        for <linux-mmc@vger.kernel.org>; Thu, 22 Mar 2012 11:02:56 -0700 (PDT)
In-Reply-To: <4F6B05BB.3080109@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Thu, Mar 22, 2012 at 11:58 AM, Ulf Hansson
<ulf.hansson@stericsson.com> wrote:
> On 03/22/2012 08:35 AM, Linus Walleij wrote:

>> - =A0 =A0 =A0 unsigned int from, nr, arg;
>> + =A0 =A0 =A0 unsigned int uninitialized_var(from);
>> + =A0 =A0 =A0 unsigned int uninitialized_var(nr);
>> + =A0 =A0 =A0 unsigned int uninitialized_var(arg);
>> =A0 =A0 =A0 =A0int err =3D 0, type =3D MMC_BLK_SECDISCARD;
>>
>> =A0 =A0 =A0 =A0if (!(mmc_can_secure_erase_trim(card) || mmc_can_sani=
tize(card))) {
>
>
> Is not the problem only related to the arg variable?

Nope the compiler complains about all three...

> What about:
> =A0 =A0 =A0 =A0unsigned int from, nr, arg =3D 0;

That also works, but we had a previous patch with that approach
NACKed in the past, the reason was that the problem does not
appear in x86 GCC, just in ARM GCC which is more sensitive.
(commit 8c320c079cde0286d71368961231e426539868b4)

By reading the code you can easily see that the variables aren't
actually used uninitialized, it's juts GCC that is unable to
follow the code path and determine that they are initialized in
all paths.

But assigning zero is fine with me, Chris may decide...

Thanks,
Linus Walleij
