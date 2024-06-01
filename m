Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75247134BC;
	Sat,  1 Jun 2024 08:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717229870; cv=none; b=YlkCWx7B4xtMjc05lUqXha4p4vgjwjn7+I4ztHYoXLBHr+qJ2MCuU/eNQDgc9BbkiO8MAHIXO1ns8SVIhodo6/P3cHVbE/d1iBHUNZd0aj5bw138quCLhxsPRLVXThb1Cc1vRmgPGkSg8kpHxxQX9mRfoHnH/YCQ1h5PDGb6k9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717229870; c=relaxed/simple;
	bh=7eeatt4CcPmiwk7FadqALe+uBEk9RzdNLVP4oBfTTKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bfyJIzG1PJRzJfFaCGj3gsqeNi4K1AIqw+mq2v+pIl7GVK7eDTEs2TGaUgRxp/zYmtfQ9YCsqq+DD3zVi5gzsN4weXib4QOJZlKpd55oE53izmrb/J5ctb0sUoxUSfirBhFxY3s3SDfxYXxIv2PotjMcK06jYJfhrtjXxKJTUAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=s6bYa9xp; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="s6bYa9xp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1717229848; x=1717834648; i=wahrenst@gmx.net;
	bh=9g8i1E4J9Qgk8VQ+f5MzIOoR/utW2DTqj5vifxeAFu0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=s6bYa9xp91jDDnaO2Kpu+8DRegMiTGOgaXKB5Mhg5+c0CxhX6N+KZEnbOhs284yb
	 201Qihxzh59QbT6NLof7RVxYhmL4pyuH7gaBq4AsthocxoV14DKBRLF4tUs3WOLKf
	 WEkW7PPdZx3/ipknLGdkZbrfqYlMEfiMg22lJJ0g+zcaJb90vbZKJFjMiF5ElEpMy
	 q/jie6giETFV+PLeGydIgqlfu/HfaEFb5HLttNT9V6JhuprZEFpMc1GymbxLRPMR+
	 VVB4wufjQ+f/hC9SwsS2T0SZXS0K9Ic+kqvghAuiikIb2zbzu4mXp4AY4+cJ+1MNN
	 fIT0Jm0KATg9WbhHlw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6bfq-1sXTkM0R6U-01528i; Sat, 01
 Jun 2024 10:17:28 +0200
Message-ID: <0a041812-875b-42e3-b303-4d984b0f9a54@gmx.net>
Date: Sat, 1 Jun 2024 10:17:26 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] Add minimal boot support for Raspberry Pi 5
To: Andrea della Porta <andrea.porta@suse.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
References: <cover.1717061147.git.andrea.porta@suse.com>
 <36642bd8-c981-4190-9f44-072ac3c97c6b@gmx.net> <ZlnJzqnvTk70O3ap@apocalypse>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <ZlnJzqnvTk70O3ap@apocalypse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:goG2aefWUGM6HYTd+wn1rjaTrNzvf9I4cz3NFvFZ99ncYKSE6rO
 iJQzkald9qRVqEJ2oEE2aeOE0fxuGQfDjplO0NPDzwkzUisk2+SS0IcrfHLc/bV4Ii1yKsf
 i9ZV5Jb5zcumld0v0rACFuw8a/vtP1ZfF1j6fzo9zY6RlJdmUrDzmjmDJlyeBO7slxHXPbj
 ZHpwb5QMnwYkjDcqWGmtQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:f4k/wUKkgVI=;4dC/SJSfIquim+tu6BbxkI3Fa50
 3mHopelSNKrGAnz6sAKWy+wmGFFdSoy5ZplfsfOF5qQXnZ5L9KbZfiZ8Ogm3/kMcFnBzd03ai
 OymQOumXnn98K93p1s1DvwQD5Y+Do/lZNywUqzjt1T+dwiqHffiZqUExRyk6T2ttfi6rgZFJl
 crBjYOLZU9PnwFxtnEYxdDsNxU0CwPzbttfoF0m/8XWrdNdg3dGdqbPrkw0Qi5jVrbkQfZeCg
 mNd3njO/3t7g4FyRBZVzVsVxaceCqMxP1iJqRZlrD7Gqogb1BVqFa6dYa2qcY0+/DXnSH0nEa
 ewvLP3kNv8dMyTYrf8p+52SzLV6KC5t0NIgd8IzRVSX4eo2vp7dzsKxfJYQjgIgUnSsySnwZ0
 f/Ws409+fdIr8qWx0/FinFJlWN4HmxcpxApcEPlrxi/bmOoL3199H9f56bFWfcJ5L8aRRspus
 cA6epR/LQxUNy0XHF7amOH9HXsBQbcpZNO1H+YE2XTdgrjggZtm1Ws/Lh6H9dJUFi5zKWyPgH
 Pw8jnMNfpUvyCeApCUfDhhK9+6BC0annUnkfc3B6nUIJdOz3cklfDQCoVeK7N76+mADDYpbE/
 qxGWSM87tkkUbW5T8iZjhhmrAI0VK4w2xpx9mr0s7PdQ3j2Scf+AhMnGFtplGBoRxW40/tzLe
 CBWTsaPyyDPebTSNyotf1ALh+Kd63qISh2hWXLsM73ZxNo4+uy6tzh7BIIv7+MLUvt3Uq9xQH
 LVVBi20eUDmQG99rWSqnzXQ4U6+z8lus8ad2ads3YjbV+z6AYGLoGkC8yY3XEV1r7evEAlAIO
 LckLuCpPucU7wz4uGz0o7BVaZahYsfiAG6UZZNVzz6eio=

Hi Andrea,

Am 31.05.24 um 14:59 schrieb Andrea della Porta:
> Hi Stefan,
>
> On 12:00 Fri 31 May     , Stefan Wahren wrote:
>> Hi Andrea,
>>
>> Am 30.05.24 um 12:11 schrieb Andrea della Porta:
>>> Hi,
>>>
>>> This patchset adds minimal support for the Broadcom BCM2712 SoC and fo=
r
>>> the on-board SDHCI controller on Broadcom BCM2712 in order to make it
>>> possible to boot (particularly) a Raspberry Pi 5 from SD card and get =
a
>>> console through uart.
>>> Changes to arm64/defconfig are not needed since the actual options wor=
k
>>> as they are.
>>> This work is heavily based on downstream contributions.
>>>
>>> Tested on Tumbleweed substituting the stock kernel with upstream one,
>>> either chainloading uboot+grub+kernel or directly booting the kernel
>>> from 1st stage bootloader. Steps to reproduce:
>>> - prepare an SD card from a Raspberry enabled raw image, mount the fir=
st
>>>     FAT partition.
>>> - make sure the FAT partition is big enough to contain the kernel,
>>>     anything bigger than 64Mb is usually enough, depending on your ker=
nel
>>>     config options.
>>> - build the kernel and dtbs making sure that the support for your root
>>>     fs type is compiled as builtin.
>>> - copy the kernel image in your FAT partition overwriting the older on=
e
>>>     (e.g. kernel*.img for Raspberry Pi OS or u-boot.bin for Tumbleweed=
).
>>> - copy arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb on FAT partiti=
on.
>>> - make sure you have a cmdline.txt file in FAT partition with the
>>>     following content:
>>>     # cat /boot/efi/cmdline.txt
>>>     root=3D/dev/mmcblk0p3 rootwait rw console=3Dtty ignore_loglevel ea=
rlycon
>>>     console=3DttyAMA10,115200
>>> - if you experience random SD issues during boot, try to set
>>>     initial_turbo=3D0 in config.txt.
>> was this an issue since the beginning of this series?
>>
> I experienced this even during early testing, using the complete downstr=
eam
> driver. It seems that when initual_turbo !=3D 0, the fw can throttle the=
 clock
> to reduce the boot time and it (directly or indirectly) may affect SD fu=
nctionality.
> I believe that the probability of this to happen is likely a function of=
 SD
> card speed, whether it requires timing tuning, initial_turbo exact value=
  and whether
> you are booting the kernel directly or chainloading u-boot + grub (or
> whatever combination of secondary stage bootloader). For example, your
> boot setup may have a timeout in the grub boot menu that is large enough=
 for the clocks
> to settle and the boot process to end successfully, while faster boot ti=
me can lead
> to the issue described. Since this behaviour seems to depend on all of t=
his factors and
> does not necessarily arise in practice, disabling initial_turbo is just =
a suggestion
> in case things go haywire.
yes in case the VPU changes the SD clock or one of the parent while the
ARM cores tries to boot, they won't be informed about these changes
which could ends up with the wrong SD clock frequency.

Thanks for your explanations
>
>> What kind of SD issues?
>>
> I wasn't able to boot from SD card due to clock issues.
>
>> Is there a downstream reference?
> Some (old) reference e.g.:
> https://forums.raspberrypi.com/viewtopic.php?t=3D112480#:~:text=3DIt%20s=
ets%20turbo%20mode%20from,have%20turbo%20during%20the%20boot.
>
> but there are probably more.
>
> Many thanks,
> Andrea

