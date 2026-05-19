Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD421331220
	for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 02:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779159114; cv=none; b=c/U29lJJ64Q3CrX6K7m/pLomTSalQLhnX5ralvbY2inw262Z5FyMD69rI3Ozu4PFSYabYhDDdnNe3Zl9n2/3IOwOAfjWEsvKfHlHH9/SUrJM8voR5qJJuD3jn45x3/QZ0CuVK12Oo181QE4r8O8QAOZozSZrmepvFTSra+LJ4SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779159114; c=relaxed/simple;
	bh=UZFcFS330gYyBLNI/cRCGasrI3mJDxBix1Wur09AIQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILeUGl9YX1rKgKSodlnoXAxWefNlmqQv8OIW8A2qaFoMP+Nyz6TLONZ8A1kATk80BK3dCcl8Ih2j7BCx3IP4F47O+1aq9xCKnv7Xh2kUBi1TQZnwVCJ/aSP0qBIj/JzyQk5WeYLZ6wHg1RWxici+a8f4qbiQ1ICKz5lFatbeA3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FA0P8SLQ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FA0P8SLQ"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-835386ff122so3172562b3a.3
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2026 19:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779159111; x=1779763911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kylF3px9z1DgmudAnFEpa2LDcEmV6MY2jY8JnaTfyKQ=;
        b=FA0P8SLQR5jMGZ9y3ta4aClr/wORu5/coRTmoMHdhSorMoT/nlqZtnuStadtbAcgJJ
         vsibPe0d/tni57t2pualYJoz+hPpgMY2A+4xzMzj1MXAzBIghPl1q0MdT4WbG/zLqyiG
         +VDo8O7EJLsd4x7n2j66k0/6MeQz97eMJQFi9zRUdo3B11cxWGC6fBxpHtlBiweVAikK
         Y6XvUq+uchISwgrfUrYQYEiLqBF9BAs0XvFXrMyryzLj7ZIA7ERUEQJbZvDOcoRnCB/4
         fQL1CseamwsLXJzHiBNd2ZW0D2vezZP5u6PqUO3HrghoeP8R6b1Lt4/mnBO5L6EA75S0
         RTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779159111; x=1779763911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kylF3px9z1DgmudAnFEpa2LDcEmV6MY2jY8JnaTfyKQ=;
        b=TJAeVbkjKOcWEtnku8xZfN4bpk38L8DDo1NRaM/B/uIjhsBxWlxn3YUF2RzdsjGkSr
         seRDz1dXFZtM3Ws3aWMWCO83wJgDolB3rp3tFIOjMT/jKdyJl0rFfctMLqQTtUfO481p
         O4ZixitdRCcLB7aqQarGu37rJMDFjQE5265hFKzQ8oQhq4EgKfzdeks7Cxp6c7J25seD
         JBmE9Z51JmKNjmOKPctz7WOq/V/0p6G8xZMj8RTU/cMRHF24eDuqOa6t7dgr4hJsQIiY
         2DJbqvGZTU8wmxewmVPUC9MnIwiET7cX1orFScaQo8W643qmXFGWmLhOhetg2YpuQEND
         j/ZA==
X-Forwarded-Encrypted: i=1; AFNElJ9bR6uwhjHgLLDKdztPjVljCapOIkp4kD7QjsbnjFz5iS0werwfPWj7cPUWu+CeKzNsmFuO9Lq+flk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh735z2wIN7BUksmYmRQfyYJ4bitLl/yM4CEwHBf3/rz1j8vE3
	DRmZRK3S8roHzRHY/+oInFvEYQx66IChG7JAcw1eEYk2rKGnt0U3HOsC
X-Gm-Gg: Acq92OF3QB8AhmeCneCR7zUqGPO0Qc3GDepTOc2PFNzFZ5bTEDYyKdC8HQry1gRrtCb
	QqJltrXMastDP+A2vnxm4nbarjRzi+nFOihZjK5QUszXxfP2RfxySrepci+8t6ZmQKwUJNBGT55
	2AJRCszpyurd7TPKzVt5Jz/TjT0lym2xXa03wLFD7PmGHyZjKJozU8u1gIhcn3gpFgVlMLYO2u1
	wkthPD9dr0dFJ54JbZNiUs3uLio0YwI6igZf+VDvfen66xnxa6ZKUO5GuOTmvB1proGF32dOM0p
	MnkDvXy1oCDJQjQ/0PFQDKR5Uy/DguG+u1pnsmqHV5ZigH4+bY6yl2gBR/uvDX4ergaXVUYQDAw
	bkv+efDKb7+Hc88SsDWssyIHQX9ZkliIwKMdNJgZfNMZK/l++LgtfqMmTdCBWhyvth+Z5M3zbXU
	Ci9pNThtP2rci2mpU2lq64XgZ34vKvkXhBAg==
X-Received: by 2002:aa7:88d1:0:b0:83d:b0a0:90e3 with SMTP id d2e1a72fcca58-83f33c344a1mr18401633b3a.31.1779159111006;
        Mon, 18 May 2026 19:51:51 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19664212sm18748771b3a.2.2026.05.18.19.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 19:51:50 -0700 (PDT)
Date: Tue, 19 May 2026 10:51:14 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: "Gabriel L. Somlo" <gsomlo@gmail.com>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Karol Gugala <kgugala@antmicro.com>, 
	Mateusz Holenko <mholenko@antmicro.com>, Joel Stanley <joel@jms.id.au>, 
	Kamil Rakoczy <krakoczy@antmicro.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v4] mmc: litex_mmc: Set mandatory idle clocks before CMD0
Message-ID: <agvN86UYsdU7Ixun@inochi.infowork>
References: <20260517015323.264179-1-inochiama@gmail.com>
 <aguQwccX_ujIoARX@errol.ini.cmu.edu>
 <aguRU9Ces7ruBbRY@inochi.infowork>
 <aguWhuNsV1KKxMeQ@errol.ini.cmu.edu>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aguWhuNsV1KKxMeQ@errol.ini.cmu.edu>

On Mon, May 18, 2026 at 06:45:26PM -0400, Gabriel L. Somlo wrote:
> On Tue, May 19, 2026 at 06:24:19AM +0800, Inochi Amaoto wrote:
> > On Mon, May 18, 2026 at 06:20:49PM -0400, Gabriel L. Somlo wrote:
> > > with this patch on top of today's latest (4d3a2a466b8d), I get
> > > (on 64-bit rocketchip with Litex):
> > > 
> > > [    6.475114] mmc0: invalid bus width
> > > [    6.477870] mmc0: error -22 whilst initialising SD card
> > > 
> > > Thanks,
> > > --Gabriel
> > > 
> > 
> > Hi, Gabriel,
> > 
> > Could you share the board link and build commands? I think I need to
> > take a look for why this occurs.
> > 
> > Regards,
> > Inochi
> 
> Hi Inochi,
> 
> it's the digilent nexys-video board; the command line to build the
> bitstream is:
> 
> litex-boards/litex_boards/targets/digilent_nexys_video.py --build \
>   --cpu-type rocket --cpu-variant linux --cpu-num-cores 4 --cpu-mem-width 2 \
>   --sys-clk-freq 50e6 --with-ethernet --with-sdcard --with-sata --sata-gen 1
> 
> (for more details see https://github.com/litex-hub/linux-on-litex-rocket)
> 
> I've added your patch on top of the LiteX kernel tree at
> https://github.com/litex-hub/linux/tree/litex-rebase
> 
> and compiled it with:
> 
> make clean
> make ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu- litex_rocket_defconfig
> make ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu-
> 
> FWIW, your previous versions of the patch did work, and did fix the
> issue you were trying to address (which I did notice being a problem
> on my configuration :)
> 
> Thanks,
> --Gabriel
>  

Hi Gabriel,

Although I fail to compile the rocket and can not reproduced this
error with VexiiRiscv, I have noticed some interesting things:

[  745.321341] mmc0: card aaaa removed
[  745.363624] litex-mmc f0004000.mmc: clock 25000000 -> 0
[  747.357770] litex-mmc f0004000.mmc: clock 0 -> 12500000
[  747.374898] litex-mmc f0004000.mmc: clock 12500000 -> 400000
[  747.706917] litex-mmc f0004000.mmc: clock 400000 -> 25000000
[  747.711954] mmc0: new SDHC card at address aaaa
[  747.722665] mmcblk0: mmc0:aaaa SL16G 14.8 GiB
[  747.751452]  mmcblk0: p1 p2

It seems like that the controller does not switch to the required init
frequency. Instead, it jump to a working frequency. It may lead to a
false reset.

Another thing is that I noticed the bios sets the PHY to x1 when
initing, but the current set_ios() does nothing with this, only
setting x4 every time that sends the command. I have added a simple
reset that changes the PHY to x1 when setting MMC_CS_HIGH.
(And I think it could be better to add bus width length handler
instead of leaving a force x4 mode).

I have prepared a new patch for these thing. Could you have a try?

Regards,
Inochi

diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
index d2f19c2dc673..97e07222872e 100644
--- a/drivers/mmc/host/litex_mmc.c
+++ b/drivers/mmc/host/litex_mmc.c
@@ -28,6 +28,7 @@
 #define LITEX_PHY_CLOCKERDIV  0x04
 #define LITEX_PHY_INITIALIZE  0x08
 #define LITEX_PHY_WRITESTATUS 0x0C
+#define LITEX_PHY_SETTINGS    0x18
 #define LITEX_CORE_CMDARG     0x00
 #define LITEX_CORE_CMDCMD     0x04
 #define LITEX_CORE_CMDSND     0x08
@@ -68,6 +69,12 @@
 #define SD_SLEEP_US       5
 #define SD_TIMEOUT_US 20000
 
+#define SD_INIT_DELAY_US  1000
+#define SD_INIT_CLK_HZ    400000
+
+#define SD_PHY_SPEED_1X 0
+#define SD_PHY_SPEED_4X 1
+
 #define SDIRQ_CARD_DETECT    1
 #define SDIRQ_SD_TO_MEM_DONE 2
 #define SDIRQ_MEM_TO_SD_DONE 4
@@ -220,6 +227,8 @@ static int litex_mmc_set_bus_width(struct litex_mmc_host *host)
 	if (ret)
 		return ret;
 
+	litex_write8(host->sdphy + LITEX_PHY_SETTINGS, SD_PHY_SPEED_4X);
+
 	/* Re-send 'app_cmd' if necessary */
 	if (app_cmd_sent) {
 		ret = litex_mmc_send_app_cmd(host);
@@ -449,6 +458,12 @@ static void litex_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct litex_mmc_host *host = mmc_priv(mmc);
 
+	if (ios->chip_select == MMC_CS_HIGH) {
+		litex_write8(host->sdphy + LITEX_PHY_SETTINGS, SD_PHY_SPEED_1X);
+		ios->clock = SD_INIT_CLK_HZ;
+		host->is_bus_width_set = false;
+	}
+
 	/*
 	 * NOTE: Ignore any ios->bus_width updates; they occur right after
 	 * the mmc core sends its own acmd6 bus-width change notification,
@@ -457,8 +472,14 @@ static void litex_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	 */
 
 	/* Update sd_clk */
-	if (ios->clock != host->sd_clk)
+	if (ios->clock != host->sd_clk) {
 		litex_mmc_setclk(host, ios->clock);
+	}
+
+	if (ios->chip_select == MMC_CS_HIGH) {
+		litex_write8(host->sdphy + LITEX_PHY_INITIALIZE, 1);
+		fsleep(SD_INIT_DELAY_US);
+	}
 }
 
 static const struct mmc_host_ops litex_mmc_ops = {
@@ -590,7 +611,7 @@ static int litex_mmc_probe(struct platform_device *pdev)
 	 * Set default sd_clk frequency range based on empirical observations
 	 * of LiteSDCard gateware behavior on typical SDCard media
 	 */
-	mmc->f_min = 12.5e6;
+	mmc->f_min = SD_INIT_CLK_HZ;
 	mmc->f_max = 50e6;
 
 	ret = mmc_of_parse(mmc);
---
