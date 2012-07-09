From: Johan Rudholm <jrudholm@gmail.com>
Subject: Re: [PATCH v1 4/5] mmc: core: Add mmc_set_blockcount feature
Date: Mon, 9 Jul 2012 19:48:19 +0200
Message-ID: <CA+20K0C7df8_kXi9AcgrCts2_wwsz-oapgFe3_3_=fOZ3wswig@mail.gmail.com>
References: <1341564244-6178-1-git-send-email-loic.pallardy@stericsson.com>
	<1341564244-6178-5-git-send-email-loic.pallardy@stericsson.com>
	<CACRpkdYYgPviMzTvtBfWmbM0CWDrwMpVrjn+Dscwx6X_xaZMuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:57295 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509Ab2GIRsU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Jul 2012 13:48:20 -0400
Received: by gglu4 with SMTP id u4so10353417ggl.19
        for <linux-mmc@vger.kernel.org>; Mon, 09 Jul 2012 10:48:19 -0700 (PDT)
In-Reply-To: <CACRpkdYYgPviMzTvtBfWmbM0CWDrwMpVrjn+Dscwx6X_xaZMuA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Loic Pallardy <loic.pallardy@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Ulf Hansson <ulf.hansson@stericcson.com>, Alex Macro <alex.macro@stericsson.com>

2012/7/8 Linus Walleij <linus.walleij@linaro.org>:
> On Fri, Jul 6, 2012 at 10:44 AM, Loic Pallardy
> <loic.pallardy@stericsson.com> wrote:
>
>> Provide support for automatically sending Set Block Count
>> (CMD23) messages. Used at least for RPMB support.
>>
>> Signed-off-by: Alex Macro <alex.macro@stericsson.com>
>> Signed-off-by: Loic Pallardy <loic.pallardy@stericsson.com>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Johan Rudholm <johan.rudholm@stericsson.com>
