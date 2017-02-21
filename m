From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH v3 7/7] ARM: dts: bcm2837: add &sdhci and &sdhost
Date: Tue, 21 Feb 2017 11:25:01 +0200
Message-ID: <20170221092501.mgov6icwxsobdeqt@tarshish>
References: <1487668026-7100-1-git-send-email-kraxel@redhat.com>
 <1487668026-7100-8-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:57679 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751018AbdBUJZH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 21 Feb 2017 04:25:07 -0500
Content-Disposition: inline
In-Reply-To: <1487668026-7100-8-git-send-email-kraxel@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-rpi-kernel@lists.infradead.org, mark.rutland@arm.com, devicetree@vger.kernel.org, ulf.hansson@linaro.org, f.fainelli@gmail.com, sbranden@broadcom.com, swarren@wwwdotorg.org, rjui@broadcom.com, lee@kernel.org, will.deacon@arm.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>, eric@anholt.net, robh+dt@kernel.org, bcm-kernel-feedback-list@broadcom.com, catalin.marinas@arm.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Gerd,

On Tue, Feb 21, 2017 at 10:07:06AM +0100, Gerd Hoffmann wrote:
> For the raspberry pi 3 we'll need both sdhci (handles sdio wifi) and
> sdhost (handles sdcard).
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Acked-by: Eric Anholt <eric@anholt.net>
> ---
>  arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Subject prefix should be 'arm64:'.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
