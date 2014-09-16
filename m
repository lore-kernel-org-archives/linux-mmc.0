From: Jean-Michel Hautbois <jhautbois@gmail.com>
Subject: Re: "Card stuck in programming state! __mmc_switch" problem on i.MX6
 + eMMC
Date: Tue, 16 Sep 2014 17:14:14 +0200
Message-ID: <CAL8zT=hahrDA++0Y3K=m5XXvwRBNRyfW2NWfQWjFV0cg6sHS2A@mail.gmail.com>
References: <54184B19.4080909@elsoft.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:41094 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753895AbaIPPOd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Sep 2014 11:14:33 -0400
Received: by mail-oa0-f54.google.com with SMTP id m19so79457oag.41
        for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2014 08:14:30 -0700 (PDT)
In-Reply-To: <54184B19.4080909@elsoft.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?Q?David_M=C3=BCller_=28ELSOFT_AG=29?= <d.mueller@elsoft.ch>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi David,

2014-09-16 16:37 GMT+02:00 David M=C3=BCller (ELSOFT AG) <d.mueller@els=
oft.ch>:
> Hello
>
> I have a custom i.MX6Q based board with a Hynix eMMC chip attached to
> USDHC3. OS is a vanilla Linux 3.16 with some patches.
>
> Loading the iMX SDHC driver results in the following error:
>
> modprobe sdhci-esdhc-imx
> sdhci: Secure Digital Host Controller Interface driver
> sdhci: Copyright(c) Pierre Ossman
> sdhci-pltfm: SDHCI platform and OF driver helper
> mmc0: no vqmmc regulator found
> mmc0: SDHCI controller on 2198000.usdhc [2198000.usdhc] using ADMA
> mmc0: BKOPS_EN bit is not set
> mmc0: Card stuck in programming state! __mmc_switch
> mmc0: error -110 whilst initialising MMC card
> mmc0: BKOPS_EN bit is not set
> mmc0: Card stuck in programming state! __mmc_switch
> mmc0: error -110 whilst initialising MMC card
> mmc0: BKOPS_EN bit is not set
> mmc0: Card stuck in programming state! __mmc_switch
> mmc0: error -110 whilst initialising MMC card
> mmc0: BKOPS_EN bit is not set
> mmc0: Card stuck in programming state! __mmc_switch
> mmc0: error -110 whilst initialising MMC card
>
>
> Pin muxing looks ok nevertheless I played around with it to see if it
> makes a difference. I also tried the "Add delay between CMD6 and CMD1=
3
> for Sandisk eMMC cards" workaround previously mentioned on this list.

Can you show your DT (at least pinmux part and usdhc3 node) ?
-110 is a timeout error and I know there is some quirks in Freescale
repository I don't know if this is your best bet...

JM
PS: Sorry for double posting, forgot linux-mmc in cc
