From: Lee Jones <lee.jones@linaro.org>
Subject: Re: Add SDHCI support for STMicroelectronics SoCs
Date: Mon, 2 Jun 2014 14:53:02 +0100
Message-ID: <20140602135302.GB4146@lee--X1>
References: <1400771902-26553-1-git-send-email-peter.griffin@linaro.org>
 <537E1B55.1090807@st.com>
 <20140602102930.GB437@griffinp-ThinkPad-X1-Carbon-2nd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:49347 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754776AbaFBNxI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Jun 2014 09:53:08 -0400
Received: by mail-ie0-f173.google.com with SMTP id lx4so4491708iec.18
        for <linux-mmc@vger.kernel.org>; Mon, 02 Jun 2014 06:53:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140602102930.GB437@griffinp-ThinkPad-X1-Carbon-2nd>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>
Cc: Maxime Coquelin <maxime.coquelin@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, chris@printf.net, ulf.hansson@linaro.org, kernel@stlinux.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org

> > >Initially it supports the stih416 and stih415 SoCs, and has
> > >been tested on a stih416-b2020 board.
> >=20
> > In next version, could you also add  drivers/mmc/host/sdhci-st.c in
> > the ARM/STI ARCHITECTURE field of MAINTAINERS file?
>=20
> Was out on hols last week. I have fixed it in v2.

This should be in its own patch.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
