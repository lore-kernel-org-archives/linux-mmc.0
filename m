From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2] mmc: dw_mmc: add quirk for broken data transfer over scheme
Date: Tue, 2 Dec 2014 09:47:18 -0800
Message-ID: <CAD=FV=V3BF8qv17n4_T5Lys1BnKsqE9NqOTB-6OwX0VOviWRrw@mail.gmail.com>
References: <1415970338-2637-1-git-send-email-addy.ke@rock-chips.com>
	<1416903008-4160-1-git-send-email-addy.ke@rock-chips.com>
	<CAD=FV=UmG1okxJ5JV-1cuRRQJi7EEPXc7Q90sWjfMWBqb7VSMw@mail.gmail.com>
	<547D6F36.50103@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f178.google.com ([209.85.220.178]:59941 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754369AbaLBRrT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Dec 2014 12:47:19 -0500
Received: by mail-vc0-f178.google.com with SMTP id hq11so5955759vcb.23
        for <linux-mmc@vger.kernel.org>; Tue, 02 Dec 2014 09:47:18 -0800 (PST)
In-Reply-To: <547D6F36.50103@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: addy ke <addy.ke@rock-chips.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Dinh Nguyen <dinguyen@altera.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Olof Johansson <olof@lixom.net>, Sonny Rao <sonnyrao@chromium.org>, Alexandru Stan <amstan@chromium.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Addy,

On Mon, Dec 1, 2014 at 11:50 PM, addy ke <addy.ke@rock-chips.com> wrote:
> We don't know why we have this problem,
> but this problem is really exist, and we need patch to fix this problem now.
> I will post a follow up change when we find the root cause.

To me that seems reasonable.  Certainly I would prefer to have this
patch while waiting for the root cause, but it's up to Ulf.


> And there is a little probability of this problem on RK SoC, such as RK3188, RK3066,
> when worse card inserted in.
> Maybe the other SoCs have the similar problem.
>
> So I will add this quirk in rockchip code(dw_mmc-rockchip.c) as follows:
> static int dw_mci_rockchip_parse_dt(struct dw_mci *host)
> {
>         host->quirk |= DW_MCI_QUIRK_BROKEN_DTO;
>
>         return 0;
> }
>
> ......
>         .parse_dt = dw_mci_rockchip_parse_dt,
> ......
>
> is right?

When you added "sdio_id0" you got feedback that you should use
dw_mci_rockchip_init().  Why not do the same thing here?
