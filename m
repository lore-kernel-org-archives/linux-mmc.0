From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 1/6] mfd: rtsx: add func to split u32 into register
Date: Mon, 8 Dec 2014 09:57:19 +0000
Message-ID: <20141208095719.GF3951@x1>
References: <cover.1417758564.git.micky_ching@realsil.com.cn>
 <17ba65f4bdf4707bdf038e407ecf5dc012bca281.1417758564.git.micky_ching@realsil.com.cn>
 <20141208084941.GC3951@x1>
 <54857429.5060108@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:52509 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbaLHJ5Z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Dec 2014 04:57:25 -0500
Received: by mail-qc0-f177.google.com with SMTP id x3so3246907qcv.36
        for <linux-mmc@vger.kernel.org>; Mon, 08 Dec 2014 01:57:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <54857429.5060108@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?utf-8?B?5pWs6ZSQ?= <micky_ching@realsil.com.cn>
Cc: "sameo@linux.intel.com" <sameo@linux.intel.com>, "chris@printf.net" <chris@printf.net>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>, "rogerable@realtek.com" <rogerable@realtek.com>, =?utf-8?B?546L54Kc?= <wei_wang@realsil.com.cn>

On Mon, 08 Dec 2014, =E6=95=AC=E9=94=90 wrote:

>=20
> On 12/08/2014 04:49 PM, Lee Jones wrote:
> >> diff --git a/include/linux/mfd/rtsx_pci.h b/include/linux/mfd/rtsx=
_pci.h
> >> >index 74346d5..9234449 100644
> >> >--- a/include/linux/mfd/rtsx_pci.h
> >> >+++ b/include/linux/mfd/rtsx_pci.h
> >> >@@ -558,6 +558,7 @@
> >> >  #define SD_SAMPLE_POINT_CTL		0xFDA7
> >> >  #define SD_PUSH_POINT_CTL		0xFDA8
> >> >  #define SD_CMD0				0xFDA9
> >> >+#define   SD_CMD_START			0x40
> > This is a different format at the others in the group on two counts=
;
> > firstly you have 3 whitespace characters after the #define and
> > secondly all of the other hex digits in the set are 4 a breast.
> > Please add the leading zeros to conform to this format.
> >
> Hi lee,
>=20
> This format is more readable, add 2 space means this value is
> in groups under register SD_CMD0, and each register value is u8 type,
> so use 2 hex digits is right.
>=20
> The original file make register address and its related value separat=
ed,
> and group register together.
>=20
> But I like to write register address and value together,
> add 2 space for value to indicate this value is related to above regi=
ster.
>=20
> If we add new address/value, I recommend write register define format=
 as=20
> below:
>=20
> #define REGISTER        addr
> #define   REG_VAL1      val1
> #define   REG_VAL2      val2

Okay, I see that there are other occurrences using this format in that
file.  Please consider converting the entire file into this format.  I
don't mind it either way, but it looks odd if they are mixed.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
