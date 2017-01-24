From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 0/2] mmc: pwrseq: add support for Marvell SD8787 chip
Date: Tue, 24 Jan 2017 10:56:13 +0100
Message-ID: <CAPDyKFpv0r8_O21=dMLXQm21PkF0oeFVogrE_pAYxcgy7B4BNA@mail.gmail.com>
References: <20170124030830.21766-1-matt@ranostay.consulting>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35743 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750734AbdAXJ4U (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Jan 2017 04:56:20 -0500
Received: by mail-wm0-f44.google.com with SMTP id r126so173134326wmr.0
        for <linux-mmc@vger.kernel.org>; Tue, 24 Jan 2017 01:56:20 -0800 (PST)
In-Reply-To: <20170124030830.21766-1-matt@ranostay.consulting>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Ranostay <matt@ranostay.consulting>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On 24 January 2017 at 04:08, Matt Ranostay <matt@ranostay.consulting> wrote:
> Changes from v1:
> * split devictree docs from pwrseq changes
> * rebase devicetree documents due to filename change
> * rebase pwrseq patchset
>
> Changes from v2:
> * update device tree bindings to powerdown-gpios and document
>   active state
>
> Changes from v3:
> * actually update patchset series
> * correct overlooked gpio to gpios renaming of properties
>
> Matt Ranostay (2):
>   devicetree: document new marvell-8xxx and pwrseq-sd8787 options
>   mmc: pwrseq: add support for Marvell SD8787 chip
>
>  .../devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt  |  16 +++
>  .../bindings/net/wireless/marvell-8xxx.txt         |   7 +-
>  drivers/mmc/core/Kconfig                           |  10 ++
>  drivers/mmc/core/Makefile                          |   1 +
>  drivers/mmc/core/pwrseq_sd8787.c                   | 117 +++++++++++++++++++++
>  5 files changed, 150 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt
>  create mode 100644 drivers/mmc/core/pwrseq_sd8787.c
>
> --
> 2.10.2
>

As I am expecting an ack from Rob soonish, I have applied this for
next to get it tested.

Kind regards
Uffe
