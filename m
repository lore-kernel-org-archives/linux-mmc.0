Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC3539A04B
	for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2026 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410101; cv=none; b=MfRo1D+Mi5FFNT83EpCFF+1ozcoc80MXKhFcHtHdjeIQHfTynLR0r3PkcC2qdD4AeCFCbhOv+kXdIpM6yJSYbwr42VyogpzgH/7uCJxd+UYHsD77xYIskc/FUHlD/AWC5lL4j2MkiW70rI55KwR3DZNlOD88jkrAKwOFgIe3P1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410101; c=relaxed/simple;
	bh=MlNJNyJrSolsmtzHNXwytk+bJl81GE0OtGhb3cJbINY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=uAfXB1YoyDEiVK7cmq5m6jlOTb5sx1vdZHMHBza4q5lhfZ4LZwUtIUvOs4p5/2uXyimdPoRm9x5HMiDe4uGLTl98rEYjZSeeyjgCV9ZEz/JTgc0FjEA/qsneeoOUMq8usOhrtMEudP36QaU67bK039gOg35sZMb6ttp4pyD9QZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=k2ToVNoS; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="k2ToVNoS"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cbb6d5f780so207220485a.1
        for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2026 06:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773410095; x=1774014895; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8NYylncmkl6iB+b/mf6sX6AvKULEGc8LEp3stTQM5KM=;
        b=k2ToVNoSKo8ln+WyZKw2EW1DjeSF+aWLmKC4YY8CzxxmWbaesvIY5+fsZ4dKh2Tc4z
         CsvC+YssGYGQ7GOw47vjN06KeDHvAnPJYauQxjoOn4B/C1vH2dvMRaFnJ3tD6+wdsqnu
         FMoH6DMHtZyHp0ZfLOMfFMQcRbevn7LE3yXXoHUkKOdM+Wt2gUmajdkhed2d2V4YxaID
         xvh6B+qR5CnTpMCYd5JGQQ8p8hhUd454fmC5uXnJjpUjvSLLoyyi0KrRfHLUrY3f91Mp
         TWpkZziXzzI2nMfBqBYpktfqg9zOPJ+P8cii6pu8U+oDRguMkyfqMgaCHa1w4Nzx9Vn1
         yDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773410095; x=1774014895;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8NYylncmkl6iB+b/mf6sX6AvKULEGc8LEp3stTQM5KM=;
        b=Z3HLBhi4zjmfFwhjWwjJBSXumiMp7PTa+Ujp4TcT1yjF5SKQBbjEG/r05hmuuMXVJj
         V1nxYCV7s03MNPI41GZdmtBAxZAxvJcwUe8c/s/YJ6zLp6zOClZ+igctRPtoAX+A7wfz
         93Bk/yYXkN8yCfUnkpegMEWPtut9AXTI4xPrdmaZJXfML27RuT8ia+HJh5aWuUBCgY6T
         Zl6CsP/m0OaifT93SbsJZxrgrAMpVtKtus2Q5WW8qO7YmHe0MuxAeBhD3D80D1MQRuQX
         b4yC7jbRFu2lhiOikNuVvRTotPZ7sIyMhuBF1XUG5ydbt+idq6CAnwAseQzHFwNZzo07
         PEOw==
X-Forwarded-Encrypted: i=1; AJvYcCVBPPMwB4vuoqpe+FCV/7GHAiuYQDkFYn233kOirgxvpBr/fud3NBSowu8vSnDirrAdMsj9/O7/mnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaY/GkUUlQEGICFCIdjqgdsGCpVnSB44EPw4xHCgUaUh3l6vrf
	LxQGlJ+IebdMnP6IuHvp9tzldUYOGFK4yG+lwW+tz+7FTgt/uWfva/Odu8fOvXw6IoQ=
X-Gm-Gg: ATEYQzzmNl9LJBV7qpW7UgONpWmV7Hnyw13Lsx3iWoJWFB8wChbKpPcPrpwBZu3Xuxw
	H3TBY9k0euwfJEos2I0232YUt7DsX8h3yGjZjjsVfWOm+obhZiYNkBq5ylZhuukmfTH974WQscQ
	Q/1XEKkNHHDkOkYlJWiXpAz1TzaBWQGfjPCebFzr+4qWRUe2MjyqqPRMe7xuv2/4rLAivp19BtM
	Lf2TKIZ+6F6DuVxKAjJL98M/JtQCOSUCHElJttIz0eU3qOJ1Uy0QLPcnB0Qfy2NNHNosKps1Mel
	jSkez8MRQL1+QSOVPYRMMAvuyIZePDS/mFTp6eExzveVER1cnS5w9WQ/cQvkSjMhHJ1BA5eh+0k
	UlUUrVO6oEI05ZKR2zbPEXaC2F+5jsiOCKRTiLQ8BCZok4rsUpbgzvV7Y6iSJd/EERBq7ohn/Tc
	srNF0W4XPtmhkr7oy0XsAMi8tuC816ZkQiq7SF4i/AR+gTtODRYpWoiZTqRltAZTL3kRIcLP34k
	wzE
X-Received: by 2002:a05:622a:c1:b0:509:8fb:3342 with SMTP id d75a77b69052e-50957dfc262mr45478541cf.56.1773410095065;
        Fri, 13 Mar 2026 06:54:55 -0700 (PDT)
Received: from ?IPV6:2001:1970:3847:e000:4c82:63a9:39e9:5c17? ([2001:1970:3847:e000:4c82:63a9:39e9:5c17])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65d1a3e5sm54240586d6.50.2026.03.13.06.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 06:54:53 -0700 (PDT)
Message-ID: <f2eeddcb-712f-4a67-9687-e217f46f9ea8@baylibre.com>
Date: Fri, 13 Mar 2026 09:54:49 -0400
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v2 7/7] riscv: dts: spacemit: k1-orangepi-rv2: add SD card
 support with UHS modes
To: Iker Pedrosa <ikerpedrosam@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Yixun Lan <dlan@kernel.org>
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>,
 Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260309-orangepi-sd-card-uhs-v2-0-5bb2b574df5d@gmail.com>
 <20260309-orangepi-sd-card-uhs-v2-7-5bb2b574df5d@gmail.com>
Content-Language: en-US
In-Reply-To: <20260309-orangepi-sd-card-uhs-v2-7-5bb2b574df5d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2026-03-09 07:40, Iker Pedrosa wrote:
> Add complete SD card controller support with UHS high-speed modes.
>
> - Enable sdhci0 controller with 4-bit bus width
> - Configure card detect GPIO with inversion
> - Connect vmmc-supply to buck4 for 3.3V card power
> - Connect vqmmc-supply to aldo1 for 1.8V/3.3V I/O switching
> - Add dual pinctrl states for voltage-dependent pin configuration
> - Support UHS-I SDR25, SDR50, and SDR104 modes
>
> This enables full SD card functionality including high-speed UHS modes
> for improved performance.
>
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---
>   arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
> index 414b03f5e6480f05f5d7eeaaa0afb4e86425ae36..361135269801f436703b6f1d768c91325a52f07f 100644
> --- a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
> +++ b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
> @@ -140,3 +140,22 @@ sd_vqmmc: aldo1 {
>   		};
>   	};
>   };
> +
> +&sdhci0 {
> +	pinctrl-names = "default", "state_uhs";
> +	pinctrl-0 = <&mmc1_cfg>;
> +	pinctrl-1 = <&mmc1_uhs_cfg>;
> +	bus-width = <4>;
> +	cd-gpios = <&gpio K1_GPIO(80) GPIO_ACTIVE_HIGH>;
> +	cd-inverted;
> +	no-mmc;
> +	no-sdio;
> +	disable-wp;
> +	cap-sd-highspeed;
> +	vmmc-supply = <&sd_vmmc>;
> +	vqmmc-supply = <&sd_vqmmc>;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +	status = "okay";
> +};
>
Hello again,

Thanks for doing this work. My colleagues and I have been testing this 
on an OrangePi RV2, and also a Muse Pi Pro board (making a similar tweak 
to this patch in k1-musepi-pro.dts). To do the testing on my end, I'm 
applying the patch series on top of 6.19 in a Yocto BSP.

I've been finding that I see issues with the UHS support on my side 
(this log comes from an image built and flashed to an SD card):


[ 1.072417] sdhci-spacemit d4280000.mmc: Got CD GPIO
[ 1.109741] mmc0: SDHCI controller on d4280000.mmc [d4280000.mmc] using 
ADMA
[ 1.114589] clk: Disabling unused clocks
[ 1.118421] PM: genpd: Disabling unused power domains
[ 1.123249] ALSA device list:
[ 1.126[ 1.129949] check access for rdinit=/init failed: -2, ignoring
[ 1.133284] Waiting for root device 
PARTUUID=e94bfdd7-a36f-4315-a480-476e2a12403d...
[ 1.176569] mmc0: new UHS-I speed DDR50 SDHC card at address aaaa
[ 1.180732] mmcblk0: mmc0:aaaa SS16G 14.8 GiB
[ 1.276268] mmcblk0: recovery failed!
[ 1.277351] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 
0x800000 phys_seg 1 prio class 2
[ 1.286346] Buffer I/O error on dev mmcblk0, logical block 0, async page 
read
[ 1.293891] mmcblk0: recovery failed!
[ 1.297289] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 
0x800000 phys_seg 1 prio class 2
[ 1.306269] Buffer I/O error on dev mmcblk0, logical block 0, async page 
read
[ 1.313522] mmcblk0: unable to read partition table


At first I wondered if maybe there was an issue with the card itself, 
but by changing the sdhci0 section to this, I'm able to read the SD just 
fine:

&sdhci0 {
          pinctrl-names = "default";
          pinctrl-0 = <&mmc1_cfg>;
          bus-width = <4>;
          cd-gpios = <&gpio K1_GPIO(80) GPIO_ACTIVE_HIGH>;
          cd-inverted;
          no-mmc;
          no-sdio;
          disable-wp;
          vmmc-supply = <&sd_vmmc>;
          vqmmc-supply = <&sd_vqmmc>;
          no-1-8-v;
          status = "okay";
};

Here's the boot log, for comparison:

[    1.068399] sdhci-spacemit d4280000.mmc: Got CD GPIO
[    1.105952] mmc0: SDHCI controller on d4280000.mmc [d4280000.mmc] 
using ADMA
[    1.110807] clk: Disabling unused clocks
[    1.114624] PM: genpd: Disabling unused power domains
[    1.119456] ALSA device list:
[    1.122[    1.126159] check access for rdinit=/init failed: -2, ignoring
[    1.129491] Waiting for root device 
PARTUUID=e94bfdd7-a36f-4315-a480-476e2a12403d...
[    1.155817] mmc0: new high speed SDHC card at address aaaa
[    1.159367] mmcblk0: mmc0:aaaa SS16G 14.8 GiB
[    1.173666] GPT:Primary header thinks Alt. header is not at the end 
of the disk.
[    1.178530] GPT:1135739 != 31116287
[    1.182045] GPT:Alternate GPT header not at the end of the disk.
[    1.188124] GPT:1135739 != 31116287
[    1.191650] GPT: Use GNU Parted to correct GPT errors.
[    1.196894]  mmcblk0: p1 p2 p3
[    1.375482] EXT4-fs (mmcblk0p3): recovery complete
[    1.379459] EXT4-fs (mmcblk0p3): mounted filesystem 
ad761819-1030-44fe-9267-f59c53c4b5c4 r/w with ordered data mode. Quota 
mode: disabled.
[    1.390400] VFS: Mounted root (ext4 filesystem) on device 179:3.


To be sure, I tried a different SDXC card with your version and saw:


[    1.064528] sdhci-spacemit d4280000.mmc: Got CD GPIO
[    1.102113] mmc0: SDHCI controller on d4280000.mmc [d4280000.mmc] 
using ADMA
[    1.106978] clk: Disabling unused clocks
[    1.110792] PM: genpd: Disabling unused power domains
[    1.115622] ALSA device list:
[    1.118[    1.122325] check access for rdinit=/init failed: -2, ignoring
[    1.125656] Waiting for root device 
PARTUUID=e94bfdd7-a36f-4315-a480-476e2a12403d...
[    1.215840] sdhci-spacemit d4280000.mmc: Tuning failed: no stable 
window found
[    1.220520] mmc0: tuning execution failed: -5
[    1.224931] mmc0: error -5 whilst initialising SD card
[    1.378228] sdhci-spacemit d4280000.mmc: Tuning failed: no stable 
window found
[    1.382901] mmc0: tuning execution failed: -5
[    1.506443] mmc0: new high speed SDXC card at address 1388
[    1.510009] mmcblk0: mmc0:1388 SATC 57.7 GiB
[    1.645467] sdhci-spacemit d4280000.mmc: Tuning failed: no stable 
window found
[    1.650158] mmc0: tuning execution failed: -5
[    1.772856] GPT:Primary header thinks Alt. header is not at the end 
of the disk.
[    1.777718] GPT:1135725 != 120930303
[    1.781317] GPT:Alternate GPT header not at the end of the disk.
[    1.787397] GPT:1135725 != 120930303
[    1.791022] GPT: Use GNU Parted to correct GPT errors.
[    1.796238]  mmcblk0: p1 p2 p3
[    1.917789] sdhci-spacemit d4280000.mmc: Tuning failed: no stable 
window found
[    1.922483] mmc0: tuning execution failed: -5
[    2.174518] sdhci-spacemit d4280000.mmc: Tuning failed: no stable 
window found
[    2.179193] mmc0: tuning execution failed: -5
[    2.337900] EXT4-fs (mmcblk0p3): mounted filesystem 
d1f9e739-cc74-4c48-a774-390717721c53 r/w with ordered data mode. Quota 
mode: disabled.
[    2.348031] VFS: Mounted root (ext4 filesystem) on device 179:3.
[    2.492089] sdhci-spacemit d4280000.mmc: Tuning failed: no stable 
window found
[    2.496771] mmc0: tuning execution failed: -5
[    2.617641] devtmpfs: mounted
[    2.618771] Freeing unused kernel image (initmem) memory: 2432K
[    2.624085] Run /sbin/init as init process
[    2.749813] sdhci-spacemit d4280000.mmc: Tuning failed: no stable 
window found
[    2.754492] mmc0: tuning execution failed: -5
[    3.013665] sdhci-spacemit d4280000.mmc: Tuning failed: no stable 
window found
[    3.018357] mmc0: tuning execution failed: -5
[    3.279459] sdhci-spacemit d4280000.mmc: Tuning failed: no stable 
window found
[    3.284139] mmc0: tuning execution failed: -5
[    3.541764] sdhci-spacemit d4280000.mmc: Tuning failed: no stable 
window found
[    3.546450] mmc0: tuning execution failed: -5
[    3.665967] I/O error, dev mmcblk0, sector 259162 op 0x0:(READ) flags 
0x880700 phys_seg 1 prio class 2
[    3.672894] I/O error, dev mmcblk0, sector 259163 op 0x0:(READ) flags 
0x880700 phys_seg 1 prio class 2
[    3.683275] I/O error, dev mmcblk0, sector 259170 op 0x0:(READ) flags 
0x880700 phys_seg 1 prio class 2
[    3.691878] I/O error, dev mmcblk0, sector 259172 op 0x0:(READ) flags 
0x880700 phys_seg 1 prio class 2
[    3.701516] I/O error, dev mmcblk0, sector 259175 op 0x0:(READ) flags 
0x880700 phys_seg 1 prio class 2
[    3.711067] I/O error, dev mmcblk0, sector 259178 op 0x0:(READ) flags 
0x880700 phys_seg 1 prio class 2
[    3.720183] I/O error, dev mmcblk0, sector 259180 op 0x0:(READ) flags 
0x880700 phys_seg 1 prio class 2
[    3.730004] I/O error, dev mmcblk0, sector 259183 op 0x0:(READ) flags 
0x880700 phys_seg 1 prio class 2
[    3.739010] I/O error, dev mmcblk0, sector 259184 op 0x0:(READ) flags 
0x880700 phys_seg 1 prio class 2
[    3.888355] sdhci-spacemit d4280000.mmc: Tuning failed: no stable 
window found
[    3.893045] mmc0: tuning execution failed: -5
[    4.149999] sdhci-spacemit d4280000.mmc: Tuning failed: no stable 
window found
[    4.154686] mmc0: tuning execution failed: -5
[    4.283933] I/O error, dev mmcblk0, sector 209865 op 0x0:(READ) flags 
0x803000 phys_seg 1 prio class 2
[    4.290750] EXT4-fs warning (device mmcblk0p3): 
ext4_dx_find_entry:1726: inode #768: lblock 1: comm swapper/0: error -5 
reading directory block
[    4.303879] Starting init: /sbin/init exists but couldn't execute it 
(error -5)
[    4.311194] Run /etc/init as init process
[    4.316220] Run /bin/init as init process
[    4.319996] Run /bin/sh as init process
[    4.457522] sdhci-spacemit d4280000.mmc: Tuning failed: no stable 
window found
[    4.462200] mmc0: tuning execution failed: -5
[    4.719271] sdhci-spacemit d4280000.mmc: Tuning failed: no stable 
window found
[    4.723945] mmc0: tuning execution failed: -5
[    4.842487] EXT4-fs warning (device mmcblk0p3): 
ext4_dx_find_entry:1726: inode #768: lblock 1: comm swapper/0: error -5 
reading directory block
[    4.852959] Starting init: /bin/sh exists but couldn't execute it 
(error -5)
[    4.860044] Kernel panic - not syncing: No working init found.  Try 
passing init= option to kernel. See Linux 
Documentation/admin-guide/init.rst for guidance.
[    4.874394] CPU: 4 UID: 0 PID: 1 Comm: swapper/0 Not tainted 
6.19.0-00008-ga23b3fad2d87 #1 NONE
[    4.883295] Hardware name: OrangePi RV2 (DT)


I don't think I've missed anything between 6.19 and 7.x, but it's 
possible. It seems like there's a timing issue at play?

Let me know if I can help with further testing. I'm also in #spacemit on 
IRC.


