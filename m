From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v4] mmc: dw_mmc: let device core setup the default pin configuration
Date: Wed, 10 Apr 2013 06:56:48 -0700
Message-ID: <CAD=FV=UddWM=yc5N9=jwbMDpZ7Bpg7o3Z714CnBSg=iHhmPxWw@mail.gmail.com>
References: <1365487186-4587-1-git-send-email-thomas.abraham@linaro.org>
	<CAD=FV=VJ-ykDNqYKQ=fqxeOD6bRNLW02VT4bjsRHRAuXLcCpQQ@mail.gmail.com>
	<CAJuYYwQT=povqiutVHXkF5jxTAnjpwTMQ5G0Z6xKGnnM7qYADQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:33164 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760323Ab3DJN4t (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Apr 2013 09:56:49 -0400
Received: by mail-la0-f43.google.com with SMTP id ek20so466325lab.16
        for <linux-mmc@vger.kernel.org>; Wed, 10 Apr 2013 06:56:48 -0700 (PDT)
In-Reply-To: <CAJuYYwQT=povqiutVHXkF5jxTAnjpwTMQ5G0Z6xKGnnM7qYADQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Girish Shivananjappa <girish.shivananjappa@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tomasz Figa <t.figa@samsung.com>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>, Linus Walleij <linus.walleij@linaro.org>, Patch Tracking <patches@linaro.org>

Thomas,

On Wed, Apr 10, 2013 at 5:48 AM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> The call to regulator_enable() is prior to the call to mmc_add_host().
> Hence, call to mmc_fre_host is not required in this case. So the above
> change should be right.

Are you sure that mmc_free_host() is the opposite of mmc_add_host()
and not mmc_alloc_host()?

I'll double-check myself in a few hours when I'm in front of a computer.

-Doug
