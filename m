Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DE036606E
	for <linux-mmc@vger.kernel.org>; Sat, 21 Feb 2026 20:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771705674; cv=none; b=EnUhe1tI024dqn3zdKtV/5emjbIKYStutLJBv2lNUYhfUWCJYDz2baqBc5WjgbGErR4dndridy40S5hFAd+hBIOxacFsOrI7RRbOD2wKmECALSsXlPURKFv+WTqLASWgvkQUAma4eaIyWvGPEAwrSqkAiXUCB5+tLN8AgK/svas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771705674; c=relaxed/simple;
	bh=zneKyBJndQq0Mj4R/3czIhM2Q/54LTosY2Thm/qYPqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZImzAeh49gha9Ns/1gaZP59huqymir/VW5mvxhnycPXnM66ComfZ7zJgFcUOt2uHWuA4g00M+/TaFcrs9jNmjuNGiCb4wVJiCBxbu1NjO77h51f68AllB/F0NPXo5/S+nIR1KYk5OZ10G9MQeFa99+6S6gcIyP5oMetBDN8Pgfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eD3ip8A+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eD3ip8A+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F785C2BC9E
	for <linux-mmc@vger.kernel.org>; Sat, 21 Feb 2026 20:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771705674;
	bh=zneKyBJndQq0Mj4R/3czIhM2Q/54LTosY2Thm/qYPqQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eD3ip8A+YBW3KNk2kDd6MXbtXNuRSpQdp+c9+UBK5cs7m4Ltt6fVt8BRxOQxXSDJe
	 fXZb5Xu25fXXKlX5Qiy04NxE/ek9dIHIhyPTTPfvGakk9wFcbYWz4YpnqMc5uJek6g
	 p56xMVQ6+GuYL6RmEK8AKFcAkmI/yfnC/0UDCgFGkYKbIbweqBj7/7Ms9JQWSU5xrR
	 WbpUjCswf/VvBEFSsBRdfuJn+XV0xgO7SRsWlX4PNnWqIGZo7Uv2doyepdw78t2iDn
	 Wbz6i0lmBPLzQRansr4DdTcy9F2NhzqM9MEtGP1iAy3O78fjtw1enSbffGdZ38QXnn
	 5pslqUa5AkPMA==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38713b53915so29833741fa.0
        for <linux-mmc@vger.kernel.org>; Sat, 21 Feb 2026 12:27:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUY1GDuoTHfFNb5On5ZENTkEYVIJCo/n9iSl4n4t1gjh1wQMzojIg4JOc9hvmPijmyT89M/VGcxFFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3jvmvKIpX1y2rBj0zhBfp040Omm4jQtcJNcWxBmL474toz9uY
	0Jwj8ZKkx0wQXrUPwlbrty8dHV+zFP5aFXdL3UEpcwet79wgJghpe+GKFvJCUZQMDb11pa+HOvj
	L3ajp1zU0kEIjnDTCL8AA5W1XGC+4tIY=
X-Received: by 2002:a2e:3212:0:b0:386:4942:246d with SMTP id
 38308e7fff4ca-38853a09209mr26215631fa.21.1771705672809; Sat, 21 Feb 2026
 12:27:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219231624.8226-3-sean.wang@kernel.org> <20260221133748.309045-1-kush.kulshrestha.5@gmail.com>
In-Reply-To: <20260221133748.309045-1-kush.kulshrestha.5@gmail.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Sat, 21 Feb 2026 14:27:41 -0600
X-Gmail-Original-Message-ID: <CAGp9Lzoq3nZS8A9m=H9JJmiCv11bWDmoLXqBLCU-Qm80k7=R1Q@mail.gmail.com>
X-Gm-Features: AaiRm51aTshfZS8JovVoAN872wiVNqYZMZDUTqUzHSK5_NRtRPr2fd9rGAtzk0U
Message-ID: <CAGp9Lzoq3nZS8A9m=H9JJmiCv11bWDmoLXqBLCU-Qm80k7=R1Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] Bluetooth: btusb: Add new VID/PID 13d3/3579 for MT7902
To: OnlineLearningTutorials <kush.kulshrestha5@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-mmc@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	sean.wang@mediatek.com, ulf.hansson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 21, 2026 at 7:38=E2=80=AFAM OnlineLearningTutorials
<kush.kulshrestha5@gmail.com> wrote:
>
> Hi Sean,
>
> Thanks for helping me to add driver for mt7902 chip.
>
> I have checked the wifi driver for mt7902 and it is working correctly wit=
h new firmware,
> earlier I have issue with old firmware, thanks.
>
> For Bluetooth driver, you already added VID/PID 13d3/3579 for MT7902
> There are some other VID/PID which are part of mt7902 bluetooth chip
>         13d3/3580 - (my chip)
>         13d3/3594 - https://github.com/OnlineLearningTutorials/mt7902_tem=
p/commit/f94e0075ca04e50629852adbb567e130f8784873
>         13d3/3596 - https://github.com/OnlineLearningTutorials/mt7902_tem=
p/commit/2a3db89c7a87241846d166defa17ebd22d4be337
>
> Please add these VID/PID or instruct me to add,

Hi Kush,

Glad to hear Wi-Fi works with the new firmware.
I=E2=80=99ll add the additional Bluetooth VID/PIDs in the next version to m=
ake
the MT7902 chipset more accessible.
Appreciate the report and logs.

> below are device debug - cat /sys/kernel/debug/usb/devices
>
>
> cat /sys/kernel/debug/usb/devices
>
> T:  Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D02 Cnt=3D01 Dev#=3D  2 Spd=3D480  =
MxCh=3D 0
> D:  Ver=3D 2.10 Cls=3Def(misc ) Sub=3D02 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
> P:  Vendor=3D13d3 ProdID=3D3580 Rev=3D 1.00
> S:  Manufacturer=3DMediaTek Inc.
> S:  Product=3DWireless_Device
> S:  SerialNumber=3D000000000
> C:* #Ifs=3D 3 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
> A:  FirstIf#=3D 0 IfCount=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01
> I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D125us
> E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 6 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
> I:  If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D125us
> E:  Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D125us
> I:* If#=3D 2 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125us
> E:  Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125us
>
>
>
> cat /sys/kernel/debug/usb/devices
>
> T: Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D02 Cnt=3D01 Dev#=3D 3 Spd=3D480 MxC=
h=3D 0
> D: Ver=3D 2.10 Cls=3Def(misc ) Sub=3D02 Prot=3D01 MxPS=3D64 #Cfgs=3D 1
> P: Vendor=3D13d3 ProdID=3D3594 Rev=3D 1.00
> S: Manufacturer=3DMediaTek Inc.
> S: Product=3DWireless_Device
> S: SerialNumber=3D000000000
> C:* #Ifs=3D 3 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
> A: FirstIf#=3D 0 IfCount=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01
> I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E: Ad=3D81(I) Atr=3D03(Int.) MxPS=3D 16 Ivl=3D125us
> E: Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E: Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E: Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D 0 Ivl=3D1ms
> E: Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D 0 Ivl=3D1ms
> I: If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E: Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D 9 Ivl=3D1ms
> E: Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D 9 Ivl=3D1ms
> I: If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E: Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D 17 Ivl=3D1ms
> E: Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D 17 Ivl=3D1ms
> I: If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E: Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D 25 Ivl=3D1ms
> E: Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D 25 Ivl=3D1ms
> I: If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E: Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D 33 Ivl=3D1ms
> E: Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D 33 Ivl=3D1ms
> I: If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E: Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D 49 Ivl=3D1ms
> E: Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D 49 Ivl=3D1ms
> I: If#=3D 1 Alt=3D 6 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E: Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D 63 Ivl=3D1ms
> E: Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D 63 Ivl=3D1ms
> I:* If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3D(none)
> E: Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D 64 Ivl=3D125us
> E: Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D 64 Ivl=3D125us
> I: If#=3D 2 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3D(none)
> E: Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125us
> E: Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125us
>
>
> cat /sys/kernel/debug/usb/devices
>
> T:  Bus=3D07 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  2 Spd=3D480  =
MxCh=3D 0
> D:  Ver=3D 2.10 Cls=3Def(misc ) Sub=3D02 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
> P:  Vendor=3D13d3 ProdID=3D3596 Rev=3D 1.00
> S:  Manufacturer=3DMediaTek Inc.
> S:  Product=3DWireless_Device
> S:  SerialNumber=3D000000000
> C:* #Ifs=3D 3 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
> A:  FirstIf#=3D 0 IfCount=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01
> I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D125us
> E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 6 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
> I:* If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3D(none)
> E:  Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D125us
> E:  Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D125us
> I:  If#=3D 2 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3D(none)
> E:  Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125us
> E:  Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125us
>
>
> Thanks
>
