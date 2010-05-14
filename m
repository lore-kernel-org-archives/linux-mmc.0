From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] sdio: add new function for RAW (Read after Write)
 operation
Date: Fri, 14 May 2010 15:06:20 -0700
Message-ID: <20100514150620.70323c76.akpm@linux-foundation.org>
References: <1272403088-4727-1-git-send-email-notasas@gmail.com>
	<AANLkTinEGhNI_n25FVZ4NrLr6ClNw3JVusnJVDZdQchn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47564 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752243Ab0ENWGi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 May 2010 18:06:38 -0400
In-Reply-To: <AANLkTinEGhNI_n25FVZ4NrLr6ClNw3JVusnJVDZdQchn@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Kalle Valo <kalle.valo@iki.fi>, linux-mmc@vger.kernel.org, dimitrysh@google.com

On Fri, 14 May 2010 14:04:17 +0300
Grazvydas Ignotas <notasas@gmail.com> wrote:

> Hi Kalle,
> 
> On Wed, Apr 28, 2010 at 12:18 AM, Grazvydas Ignotas <notasas@gmail.com> wrote:
> > SDIO specification allows RAW (Read after Write) operation using
> > IO_RW_DIRECT command (CMD52) by setting the RAW bit. This operation is
> > similar to ordinary read/write commands, except that both write and read
> > are performed using single command/response pair. The Linux SDIO layer
> > already supports this internaly, only external function is missing for
> > drivers to make use, which is added by this patch.
> >
> > This type of command is required to implement proper power save mode
> > support in wl1251 wifi driver.
> 
> As wl1251 maintainer, can you confirm this is needed for wl1251 driver
> to function in SDIO mode? Perhaps this could help convince Andrew to
> merge this patch.

I kinda ducked the patch because there are no callers of the function.

> Without this the chip is having problems leaving ELP
> mode. Android has similar patch for G1 in it's tree for the same
> reason:
> 
> http://android.git.kernel.org/?p=kernel/common.git;a=commitdiff;h=74a47786f6ecbe6c1cf9fb15efe6a968451deb52

Well let's cc Dmitry then.  Dmitry's patch is somewhat different from
yours and that needs to be looked at.

Some comments:

: From: Grazvydas Ignotas <notasas@gmail.com>
: 
: SDIO specification allows RAW (Read after Write) operation using
: IO_RW_DIRECT command (CMD52) by setting the RAW bit.  This operation is
: similar to ordinary read/write commands, except that both write and read
: are performed using single command/response pair.  The Linux SDIO layer
: already supports this internaly, only external function is missing for
: drivers to make use, which is added by this patch.
: 
: This type of command is required to implement proper power save mode
: support in wl1251 wifi driver.
: 
: Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
: Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
: ---
: 
:  drivers/mmc/core/sdio_io.c    |   31 +++++++++++++++++++++++++++++++
:  include/linux/mmc/sdio_func.h |    3 +++
:  2 files changed, 34 insertions(+)
: 
: diff -puN drivers/mmc/core/sdio_io.c~sdio-add-new-function-for-raw-read-after-write-operation drivers/mmc/core/sdio_io.c
: --- a/drivers/mmc/core/sdio_io.c~sdio-add-new-function-for-raw-read-after-write-operation
: +++ a/drivers/mmc/core/sdio_io.c
: @@ -406,6 +406,37 @@ void sdio_writeb(struct sdio_func *func,
:  EXPORT_SYMBOL_GPL(sdio_writeb);
:  
:  /**
: + *	sdio_writeb_readb - write and read a byte from SDIO function
: + *	@func: SDIO function to access
: + *	@b: byte to write
: + *	@addr: address to write to
: + *	@err_ret: optional status value from transfer
: + *
: + *	Performs a RAW (Read after Write) operation as defined by SDIO spec -
: + *	single byte is written to address space of a given SDIO function and
: + *	response is read back from the same address, both using single request.
: + *	If there is a problem with the operation, 0xff is returned and
: + *	@err_ret will contain the error code.
: + */
: +u8 sdio_writeb_readb(struct sdio_func *func, u8 b,

"b" is a poor name.  Please choose something meaningful.

: +	unsigned int addr, int *err_ret)
: +{
: +	int ret;
: +	u8 val;
: +
: +	BUG_ON(!func);

This test doesn't gain us much.  If `func' is NULL, we'll reliably oops
when dereferencing it, which gives the same info as the BUG_ON().

: +	ret = mmc_io_rw_direct(func->card, 1, func->num, addr, b, &val);
: +	if (err_ret)
: +		*err_ret = ret;
: +	if (ret)
: +		val = 0xff;
: +
: +	return val;
: +}
: +EXPORT_SYMBOL_GPL(sdio_writeb_readb);
: +
: +/**
:   *	sdio_memcpy_fromio - read a chunk of memory from a SDIO function
:   *	@func: SDIO function to access
:   *	@dst: buffer to store the data
: diff -puN include/linux/mmc/sdio_func.h~sdio-add-new-function-for-raw-read-after-write-operation include/linux/mmc/sdio_func.h
: --- a/include/linux/mmc/sdio_func.h~sdio-add-new-function-for-raw-read-after-write-operation
: +++ a/include/linux/mmc/sdio_func.h
: @@ -145,6 +145,9 @@ extern void sdio_writew(struct sdio_func
:  extern void sdio_writel(struct sdio_func *func, u32 b,
:  	unsigned int addr, int *err_ret);
:  
: +extern u8 sdio_writeb_readb(struct sdio_func *func, u8 b,
: +	unsigned int addr, int *err_ret);
: +
:  extern int sdio_memcpy_toio(struct sdio_func *func, unsigned int addr,
:  	void *src, int count);
:  extern int sdio_writesb(struct sdio_func *func, unsigned int addr,


