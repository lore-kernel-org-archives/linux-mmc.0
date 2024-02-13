Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F1D5FBA2
	for <linux-mmc@vger.kernel.org>; Tue, 13 Feb 2024 17:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844108; cv=none; b=JppgdZel2LF6kyHw6Bi7L6ZG3U2Gk2QwOJIVxHy4JJv2E9ix5kdRIsOgCRVgOPOVAhU1T1Wy6sX8AwPBr0L4I7BFyR0Yg1BVRharsqrw0O7PuoabpK6BowuivzDkBX2RkJCdYZeecL6HYCQcg07o3RFpfs5I9vApnhe1smU++SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844108; c=relaxed/simple;
	bh=LYH9G16owoiQc2zjjn+FIjNJu//wkldV8uQ1hDcVPwY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=EhlCIbVgcgg6kXx31eAScuzX1Xx02yHyYf6o/ix1mrJwcUxrEMUsUG8vcn/dl125V9I0XCTdGXQmkLShn4jSGTbjia2pHRDr7M55nWeGp7hCJfz4QKBthkxauEOqqULCDu8E5bSJGx5t8l65BCxHp7xwd2qan/22jAEcSTpCFvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVBXP0LF; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVBXP0LF"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33b1d7f736bso793082f8f.3
        for <linux-mmc@vger.kernel.org>; Tue, 13 Feb 2024 09:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707844104; x=1708448904; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RIdHArSuo+enb7F0NImkd1XDVwnqmG4CQxNnqHKLMU=;
        b=NVBXP0LFq+GYt/YgMe7NjLfvKTSG5hF8a4qoMQI2LPvb35/S8eSAYKvpd2Ms0TdDGh
         VQvqoNM1y2lrn0GvkOA8gHWzxdWs2HBm33FlPWfO8qvBxbVekylUnBkkJk9En17QsUpK
         ecZfNZcU1s2nmwD1aBMB4JOsZfyXlSMCMd+uDhIq2dK33F6crAa+l1rJqVZXR5e9mY2R
         48elhMyTWbIHs9lUiHxYX2idK+UFED048m1wqlEszC4XVa24wRKO9ieJP5TAuEDB1dsx
         6mWdvGEdtoyUH8yl/SedZLWxys3egv8VkeOs3e/Z+BUOmps820pasHyX4MtTU0tNQkNv
         pOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707844104; x=1708448904;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4RIdHArSuo+enb7F0NImkd1XDVwnqmG4CQxNnqHKLMU=;
        b=mrvYojIwrBkChZ/5rJ7zEbqf1hb04k05TF+0h6WQkthlzowyQ8YXyrGiosjFlIBBcA
         VrcqtvQERkDQTSldM2G8q5oeBxaJNQVOlcZbBPO2hyD3p91CQqRJThQXE02d1KX8tMoJ
         DbNT40euZJIf6oTUqqsF5d2/kEi+mAZfOXaW2Wpefx2Cr/Dzhvgvk/RdYFi/x00h4SVy
         MbYctSghndnhCDRfX7sHT8ds1rFjdtPl2QNcn89G7ZJhkgaOuwBDuz0F5DVNHOxIvqer
         WmMId30sLHSdi8rxijJEzhfeOwTlq5WvtQNa90SHot3KG23FZ8qT6V1ChiRI1a9xhphD
         qCqg==
X-Forwarded-Encrypted: i=1; AJvYcCWHErWuoB7SQiTlgVyPQfUwPE7es96h5BdeU4wVUl/ZD0A418kQvbhr6b0AYsRYJuqRF8hDP9PzbmbYj5mK6vx7oMKdlxgCKp9o
X-Gm-Message-State: AOJu0Yz5R92E9x3Q0xkFsEnTKslVP792NVqng1CKgSU7hAqnUCGaYy6j
	lPgrLZpshTH/hsf4wkowwzxl17+aHkv17BNxAvqzRo5BsdBY11Ta
X-Google-Smtp-Source: AGHT+IErn252/1n8EZz5uVup7xJppdf9uZNL/4SRUOmZgBlO4CCYqRd6Aj+eYpi5byMs/xLLZCzXDQ==
X-Received: by 2002:adf:a381:0:b0:33a:eb7c:2bbb with SMTP id l1-20020adfa381000000b0033aeb7c2bbbmr7952262wrb.11.1707844103952;
        Tue, 13 Feb 2024 09:08:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUx/4ms/C2qCwEpNbt2URBCohT3w5gwfl/MH9QKE/3sUeo8Sex5gwBcwWcLTTGHjmTV0/YQNRNlPpE94o3+WPfPQ8zAmF5zKL33migYRUQtyfkgvjfvNKof3gBdTYIk2w==
Received: from smtpclient.apple ([31.216.122.163])
        by smtp.gmail.com with ESMTPSA id az17-20020adfe191000000b0033b87c2725csm4465637wrb.104.2024.02.13.09.08.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Feb 2024 09:08:23 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH] mmc: Fix eMMC initialization with 1-bit bus connection
From: Ivan Semenov <vanyas@gmail.com>
In-Reply-To: <CAPDyKFpfHyhuRBT7yQ_jCe_XBg0VbP90fr3vLy6v-DLgq7sCzQ@mail.gmail.com>
Date: Tue, 13 Feb 2024 19:08:11 +0200
Cc: Ivan Semenov <ivan@semenov.dev>,
 linux-mmc@vger.kernel.org,
 tgih.jun@samsung.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <0ED18BA8-1F24-4A2C-8A16-1D2A7DDDD7A6@gmail.com>
References: <20240206172845.34316-1-ivan@semenov.dev>
 <CAPDyKFpfHyhuRBT7yQ_jCe_XBg0VbP90fr3vLy6v-DLgq7sCzQ@mail.gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
X-Mailer: Apple Mail (2.3774.300.61.1.2)



> On Feb 13, 2024, at 18:40, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>=20
> On Tue, 6 Feb 2024 at 18:28, Ivan Semenov <ivan@semenov.dev> wrote:
>>=20
>> The Linux mmc driver currently encounters a problem with eMMC chips =
connected via a 1-bit bus, when the chip supports a 4-bit bus. This =
regression was introduced in commit 577fb13 after functioning correctly =
in kernel version 3.15.
>>=20
>> In the function mmc_select_bus_width, the driver attempts to switch =
to 8-bit and 4-bit modes, but if the 4-bit bus test fails, it does not =
fall back to 1-bit mode and leaves eMMC in broken 4-bit mode. This =
results in I/O errors and failure to read the partition table.
>>=20
>> This patch addresses the issue by ensuring that the driver fallback =
to 1-bit bus mode if the attempt to switch to 4-bit mode fails.
>>=20
>> dmesg log for Samsung eMMC 5.1 chip connected  via 1bit bus (only D0 =
pin) before patch:
>=20
> Wow, that was an old bug you found there.
>=20
> Just to make sure I understand correctly, the platform only supports
> 1-bit bus, but the DTS doesn't reflect that correctly as it instead
> indicates that 4 and 8-bit modes are supported?

Yes, you are correct, and the second case - with no DTS, when emmc is
connected to PC via cardreader, but via 1bit connection only

>=20
> Don't get me wrong, I think the initialization-error-path should be
> able to cope with that, so we should certainly fix it!
>=20
>>=20
>> [134509.044225] mmc0: switch to bus width 4 failed
>> [134509.044509] mmc0: new high speed MMC card at address 0001
>> [134509.054594] mmcblk0: mmc0:0001 BGUF4R 29.1 GiB
>> [134509.281602] mmc0: switch to bus width 4 failed
>> [134509.282638] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags =
0x0 phys_seg 1 prio class 2
>> [134509.282657] Buffer I/O error on dev mmcblk0, logical block 0, =
async page read
>> [134509.284598] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags =
0x0 phys_seg 1 prio class 2
>> [134509.284602] Buffer I/O error on dev mmcblk0, logical block 0, =
async page read
>> [134509.284609] ldm_validate_partition_table(): Disk read failed.
>> [134509.286495] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags =
0x0 phys_seg 1 prio class 2
>> [134509.286500] Buffer I/O error on dev mmcblk0, logical block 0, =
async page read
>> [134509.288303] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags =
0x0 phys_seg 1 prio class 2
>> [134509.288308] Buffer I/O error on dev mmcblk0, logical block 0, =
async page read
>> [134509.289540] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags =
0x0 phys_seg 1 prio class 2
>> [134509.289544] Buffer I/O error on dev mmcblk0, logical block 0, =
async page read
>> [134509.289553]  mmcblk0: unable to read partition table
>> [134509.289728] mmcblk0boot0: mmc0:0001 BGUF4R 31.9 MiB
>> [134509.290283] mmcblk0boot1: mmc0:0001 BGUF4R 31.9 MiB
>> [134509.294577] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags =
0x80700 phys_seg 1 prio class 2
>> [134509.295835] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags =
0x0 phys_seg 1 prio class 2
>> [134509.295841] Buffer I/O error on dev mmcblk0, logical block 0, =
async page read
>>=20
>> After patch:
>>=20
>> [134551.089613] mmc0: switch to bus width 4 failed
>> [134551.090377] mmc0: new high speed MMC card at address 0001
>> [134551.102271] mmcblk0: mmc0:0001 BGUF4R 29.1 GiB
>> [134551.113365]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 =
p14 p15 p16 p17 p18 p19 p20 p21
>> [134551.114262] mmcblk0boot0: mmc0:0001 BGUF4R 31.9 MiB
>> [134551.114925] mmcblk0boot1: mmc0:0001 BGUF4R 31.9 MiB
>=20
> To allow me to apply the patch, you need to provide your
> Signed-off-by-tag. According to the below:
>=20
> Signed-off-by: Ivan Semenov <ivan@semenov.dev>
>=20
> Please tell me if you are okay with that, then I can amend the patch
> when applying. No need for you to post a new version.

I=E2=80=99m ok with that, is it ok to put it here or I need to send a =
patch again?
Signed-off-by: Ivan Semenov <ivan@semenov.dev>

>=20
>> ---
>> drivers/mmc/core/mmc.c | 2 ++
>> 1 file changed, 2 insertions(+)
>>=20
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index f410bee50132..58ed7193a3ca 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1015,10 +1015,12 @@ static int mmc_select_bus_width(struct =
mmc_card *card)
>>        static unsigned ext_csd_bits[] =3D {
>>                EXT_CSD_BUS_WIDTH_8,
>>                EXT_CSD_BUS_WIDTH_4,
>> +               EXT_CSD_BUS_WIDTH_1,
>>        };
>>        static unsigned bus_widths[] =3D {
>>                MMC_BUS_WIDTH_8,
>>                MMC_BUS_WIDTH_4,
>> +               MMC_BUS_WIDTH_1,
>>        };
>>        struct mmc_host *host =3D card->host;
>>        unsigned idx, bus_width =3D 0;
>=20
> For my understanding, does your platform support HS200 mode too? Or
> only high-speed mode?
>=20
> The reason for my question is that it would be interesting to
> understand whether we end up running the error path in
> mmc_select_hs200() or not.

In my case, platform supports only High-Speed mode, so I can=E2=80=99t =
test in
with HS200 mode.

>=20
> [...]
>=20
> Kind regards
> Uffe


