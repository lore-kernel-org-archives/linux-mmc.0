From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Sandisk MMC I/O errors
Date: Tue, 5 Aug 2014 12:35:16 -0300
Message-ID: <CAOMZO5B36yQx-renFLaPDSY12kmPuPGVOkXT3nJKb2gRhdTdPQ@mail.gmail.com>
References: <CAL8zT=iinDtm3_77jSDWG1RSjN5CgEtAgPjA_ju3-=ZS2Qco8A@mail.gmail.com>
	<CAOMZO5ABt9kwxdfk-tKMTc76jY==fJtPd7AoPZoGvHvSDM6xXg@mail.gmail.com>
	<CAL8zT=iKKqQeOJk+X4tExA4nSatNHK2VagoaC2Ar+oKjjbWahA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:38905 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754579AbaHEPfS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Aug 2014 11:35:18 -0400
Received: by mail-lb0-f171.google.com with SMTP id l4so882838lbv.16
        for <linux-mmc@vger.kernel.org>; Tue, 05 Aug 2014 08:35:16 -0700 (PDT)
In-Reply-To: <CAL8zT=iKKqQeOJk+X4tExA4nSatNHK2VagoaC2Ar+oKjjbWahA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Tue, Aug 5, 2014 at 12:20 PM, Jean-Michel Hautbois
<jean-michel.hautbois@vodalys.com> wrote:

> Thanks. Here are my settings (I used the imx6qdl-sabresd as an example) :
>
> pinctrl_usdhc4: usdhc4grp {
>   fsl,pins = <
>     MX6QDL_PAD_SD4_CMD__SD4_CMD 0x17059
>     MX6QDL_PAD_SD4_CLK__SD4_CLK 0x10059
>     MX6QDL_PAD_SD4_DAT0__SD4_DATA0 0x17059
>     MX6QDL_PAD_SD4_DAT1__SD4_DATA1 0x17059
>     MX6QDL_PAD_SD4_DAT2__SD4_DATA2 0x17059
>     MX6QDL_PAD_SD4_DAT3__SD4_DATA3 0x17059
>     MX6QDL_PAD_SD4_DAT4__SD4_DATA4 0x17059
>     MX6QDL_PAD_SD4_DAT5__SD4_DATA5 0x17059
>     MX6QDL_PAD_SD4_DAT6__SD4_DATA6 0x17059
>     MX6QDL_PAD_SD4_DAT7__SD4_DATA7 0x17059
>   >;
> };
>
> &usdhc4 {
>     pinctrl-names = "default";
>     pinctrl-0 = <&pinctrl_usdhc4>;
>     bus-width = <8>;
>     non-removable;
>     no-1-8-v;
>     status = "okay";
> };

Which kernel version are using? Does your board use the exact same
pins as mx6qsabresd for the eMMC?
