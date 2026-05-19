Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096F8800
	for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 01:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779153149; cv=none; b=CH1N78jDYqj1lrA/WMdvXWmElrw1g+KQrmWS4pyz4wamHX0qhmvCzctio4ewdyTPgIj277ki79KUj5/xj3byfMYD33VC/REd3Bre/j9ZlGtZX0ZqLcwzXbXLco5rpLEHJEs7n1J5cYFNrqxAqzHAKKESxjxiDWR5hahwHjd8MdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779153149; c=relaxed/simple;
	bh=E8mvYkiDysCNvTxyQZWLY9RqVrSDTfX/V9InuvyC/Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWVibEYgE57lpnZDhEGBBGoixFJaUIGsghvcCfiWNFF1P59cTBHwhipGOHamPeuyJLTnYADQPQQ9MsIytc3nMOaCS4LZmbKxSNtW8ekSBbuwgsZ5sPl19Hr+lhSyynfR4I93ok/cOzmeRUW2MUOWQlK1nFtdcfMYra4VXDkxav4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RX/tDyFG; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RX/tDyFG"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-365eecc5885so2679041a91.0
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2026 18:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779153147; x=1779757947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uQueVlPXlLD0vlLyk4OzSC3ndACwP5iDFj75AnWiPCM=;
        b=RX/tDyFGZ/P14/PQZHPzeuNjtBeTWD6REVDnbRvjY+0qWh6S/L0y4s3AXPeb2Y7/0v
         CnEuLN4eG1ykPZJon5UtyafS4eNbL/Yz5z7XQFxG1tSHhuZKMQBDziE1xBpApqqgjRsa
         LwkeuxaKL60EVDuxw1E4ZSftnQL0Z6Bs9bdf+OTD1S5HKaZFUQ+cv2soB0DNipULUc3Y
         FcmaH592iJBScd6iUPhjHb4SFWpUVho6gcoWBnU8fPXcMoKJ8yTYEO/uAhHTLHLjkd4a
         tBz4cw5jNf4TPoPooz0nPG/H6q6Ss7YesFrM6Vt86blKGg0ONO1Qo8JS9vXj82MhEzpy
         anYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779153147; x=1779757947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQueVlPXlLD0vlLyk4OzSC3ndACwP5iDFj75AnWiPCM=;
        b=InamEpkvojYfoB8vkBTlyqzKocuI83HFrRJQ8DdsmPwXrnbPxgkOYL3CfVQeSLuFXl
         lrGmtb/iyqfDXsofNPX5MOomTkvT5w4lvNl0fcwEODTWbCfVBHcRRF8HfUzxmvJxg3Rb
         gO3NtMySBkvSBhPSahkq89doDrF7XzmgkhjNok86fvLftxIGzKJwXag6OO5otLlIrpnz
         8LeVVzQbmocGmB2RTu4a988PzP+K0TwYi9P9AtEkqz/MTkilqWhYMeh6joUYtjY/oNFm
         gohk5nVtGxNp+SHW96Nsvp3eOWSoB+QiR5pIqL6jR2fhDocEJEF6Oc8y5vCVsp0jU9Eo
         SsjQ==
X-Forwarded-Encrypted: i=1; AFNElJ8y2yacUWzqmGEmcVgbslZaLy72dzkFTQ/1+KFP9WCiFE6poj50nsDo3oQ+Yi0mKcYBLGJbb9QMATA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSJPulUQHDOREE2qDdeh6YxTGCDah36k0so0hVv161fbVDraZ8
	Qn5yONNsyVejJ5EkIjcZ36DRMPShEcRJ9Tark/eAjq7iVmB+XFYJKaEF
X-Gm-Gg: Acq92OGdu2QOc4iqOD+NYrHWyV7XDEjDk90JXMlhlaVuwd3g5/sTZeV6yYPtsmIQxW0
	2ESE9v5Med1eyQ3+qKqRLBstk112Cynx3LhTJ/WiDOQ3Ry0X6FpA13pf4u6Xfss4byWKk8lqow1
	IfVcsWraBQ5tO6/tLjKkAvL8J4EYMVV0XE6gdvT45L9N6f8JUPptbBO6CHYyG/jL0E5LW+shlgw
	IYMahlIUt0PZDhS3V14vYfIqOviIU2pRGap6vy4EkaHMPLhg7Y6paLZiGCfqeN3BMs/0hto5Xhv
	/8IeggDJCMpviHEz45oNAapyffUjgZgYQuEeYz//+sDbREVSI4Tchr+SOZWaRy1+Urd30Q1kj7T
	xHLiEIL5wOCIf1Y3nXlgR5Q37qL6nkZfBAtezp27G0XvJ8oQ2RSIjIgdjFjgps40QzvZUW7dqv/
	cRvhRp4orowgMAbLbLNbvR+Mo=
X-Received: by 2002:a17:90b:2743:b0:368:b176:c5a8 with SMTP id 98e67ed59e1d1-36951b76e8emr17643332a91.15.1779153147152;
        Mon, 18 May 2026 18:12:27 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369517ed182sm12623623a91.15.2026.05.18.18.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 18:12:26 -0700 (PDT)
Date: Tue, 19 May 2026 09:11:51 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: "Gabriel L. Somlo" <gsomlo@gmail.com>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Karol Gugala <kgugala@antmicro.com>, 
	Mateusz Holenko <mholenko@antmicro.com>, Joel Stanley <joel@jms.id.au>, 
	Kamil Rakoczy <krakoczy@antmicro.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v4] mmc: litex_mmc: Set mandatory idle clocks before CMD0
Message-ID: <agu2tV5tFi2pzNWN@inochi.infowork>
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

Hi, Gabriel,

Could you do me a favor by testing this patch (and the new patch below)
on the VexiiRiscv. My own board does not have a "rst" pin. I guess that
gives some difference? The build command could be:
./litex-boards/litex_boards/targets/riguke_xcku5p.py \
  --build --update-repo=no --cpu-type vexiiriscv --cpu-variant debian \
  --cpu-count 4 \
  --with-coherent-dma --no-netlist-cache \
  --sys-clk-freq 150000000.0 --libc-mode full \
  --with-isa sstc \
  --with-sdcard --with-ethernet

--with-coherent-dma is a requirement for sdcard, and others you
can modify freely.

Anyway, there is a new slice that mitigates the side effect of
changing the ios->clock. Could you have a try? Hope this could
solve the problem.

Regards,
Inochi

diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
index d2f19c2dc673..95fc07d9a613 100644
--- a/drivers/mmc/host/litex_mmc.c
+++ b/drivers/mmc/host/litex_mmc.c
@@ -68,6 +68,9 @@
 #define SD_SLEEP_US       5
 #define SD_TIMEOUT_US 20000
 
+#define SD_INIT_DELAY_US  1000
+#define SD_INIT_CLK_HZ    400000
+
 #define SDIRQ_CARD_DETECT    1
 #define SDIRQ_SD_TO_MEM_DONE 2
 #define SDIRQ_MEM_TO_SD_DONE 4
@@ -448,6 +451,10 @@ static void litex_mmc_setclk(struct litex_mmc_host *host, unsigned int freq)
 static void litex_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct litex_mmc_host *host = mmc_priv(mmc);
+	unsigned int ios_clock = ios->clock;
+
+	if (ios->chip_select == MMC_CS_HIGH)
+		ios_clock = SD_INIT_CLK_HZ;
 
 	/*
 	 * NOTE: Ignore any ios->bus_width updates; they occur right after
@@ -457,8 +464,13 @@ static void litex_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	 */
 
 	/* Update sd_clk */
-	if (ios->clock != host->sd_clk)
+	if (ios_clock != host->sd_clk)
 		litex_mmc_setclk(host, ios->clock);
+
+	if (ios->chip_select == MMC_CS_HIGH) {
+		litex_write8(host->sdphy + LITEX_PHY_INITIALIZE, 1);
+		fsleep(SD_INIT_DELAY_US);
+	}
 }
 
 static const struct mmc_host_ops litex_mmc_ops = {

> > > On Sun, May 17, 2026 at 09:53:23AM +0800, Inochi Amaoto wrote:
> > > > The litex_mmc driver assumes the card is already probed in the BIOS
> > > > and skip the phy initialization. This will cause the command fail
> > > > like the following when the old card is unplugged and then insert
> > > > a new card:
> > > > 
> > > > [   62.923593] litex-mmc f0004000.mmc: Command (cmd 8) error, status -110
> > > > [   62.949717] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
> > > > [   62.976606] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
> > > > [   63.002516] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
> > > > [   63.028442] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
> > > > 
> > > > Add required clock settings and initialization for the CMD 0, so it can
> > > > probe the new card.
> > > > 
> > > > Fixes: 92e099104729 ("mmc: Add driver for LiteX's LiteSDCard interface")
> > > > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > > > ---
> > > > Changed from v3:
> > > > - https://lore.kernel.org/linux-mmc/20260426112016.1370929-1-inochiama@gmail.com/
> > > > 1. Remove patch 1: mmc: litex_mmc: Move litex_mmc_setclk() to bottom for reuse
> > > > 2. Use set_ios() callback to apply the clock change.
> > > > 
> > > > Changed from v2:
> > > > - https://lore.kernel.org/linux-mmc/20260424013615.470325-1-inochiama@gmail.com/
> > > > 1. Remove the added function forward reference and add a new patch
> > > >    for moving litex_mmc_setclk() function
> > > > 
> > > > Change from v1:
> > > > - https://lore.kernel.org/linux-mmc/20260421025052.755471-1-inochiama@gmail.com/
> > > > 1. use fsleep to replace udelay
> > > > 
> > > > Inochi Amaoto (2):
> > > >   mmc: litex_mmc: Move litex_mmc_setclk() to bottom for reuse
> > > >   mmc: litex_mmc: Set mandatory idle clocks before CMD0
> > > > 
> > > >  drivers/mmc/host/litex_mmc.c | 37 ++++++++++++++++++++++--------------
> > > >  1 file changed, 23 insertions(+), 14 deletions(-)
> > > > ---
> > > >  drivers/mmc/host/litex_mmc.c | 11 +++++++++++
> > > >  1 file changed, 11 insertions(+)
> > > > 
> > > > diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
> > > > index d2f19c2dc673..65d5c728f536 100644
> > > > --- a/drivers/mmc/host/litex_mmc.c
> > > > +++ b/drivers/mmc/host/litex_mmc.c
> > > > @@ -68,6 +68,9 @@
> > > >  #define SD_SLEEP_US       5
> > > >  #define SD_TIMEOUT_US 20000
> > > > 
> > > > +#define SD_INIT_DELAY_US  1000
> > > > +#define SD_INIT_CLK_HZ    400000
> > > > +
> > > >  #define SDIRQ_CARD_DETECT    1
> > > >  #define SDIRQ_SD_TO_MEM_DONE 2
> > > >  #define SDIRQ_MEM_TO_SD_DONE 4
> > > > @@ -449,6 +452,9 @@ static void litex_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > > >  {
> > > >  	struct litex_mmc_host *host = mmc_priv(mmc);
> > > > 
> > > > +	if (ios->chip_select == MMC_CS_HIGH)
> > > > +		ios->clock = SD_INIT_CLK_HZ;
> > > > +
> > > >  	/*
> > > >  	 * NOTE: Ignore any ios->bus_width updates; they occur right after
> > > >  	 * the mmc core sends its own acmd6 bus-width change notification,
> > > > @@ -459,6 +465,11 @@ static void litex_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > > >  	/* Update sd_clk */
> > > >  	if (ios->clock != host->sd_clk)
> > > >  		litex_mmc_setclk(host, ios->clock);
> > > > +
> > > > +	if (ios->chip_select == MMC_CS_HIGH) {
> > > > +		litex_write8(host->sdphy + LITEX_PHY_INITIALIZE, 1);
> > > > +		fsleep(SD_INIT_DELAY_US);
> > > > +	}
> > > >  }
> > > > 
> > > >  static const struct mmc_host_ops litex_mmc_ops = {
> > > > --
> > > > 2.54.0
> > > > 
