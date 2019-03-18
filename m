From: GregKH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4.9.y] mmc: tmio_mmc_core: don't claim spurious
 interrupts
Date: Mon, 18 Mar 2019 09:07:53 +0100
Message-ID: <20190318080753.GC4746@kroah.com>
References: <e82bd7bc-3e47-0ac9-ce43-5fb809644f9f@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e82bd7bc-3e47-0ac9-ce43-5fb809644f9f@cogentembedded.com>
Sender: stable-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Sun, Mar 17, 2019 at 09:11:31PM +0300, Sergei Shtylyov wrote:
> Commit 5c27ff5db1491a947264d6d4e4cbe43ae6535bae upstream.
> 
> I have encountered an interrupt storm during the eMMC chip probing (and
> the chip finally didn't get detected).  It turned out that U-Boot left
> the DMAC interrupts enabled while the Linux driver  didn't use those.
> The SDHI driver's interrupt handler somehow assumes that, even if an
> SDIO interrupt didn't happen, it should return IRQ_HANDLED.  I think
> that if none of the enabled interrupts happened and got handled, we
> should return IRQ_NONE -- that way the kernel IRQ code recoginizes
> a spurious interrupt and masks it off pretty quickly...
> 
> Fixes: 7729c7a232a9 ("mmc: tmio: Provide separate interrupt handlers")
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is against the 'linux-4.9.y' branch of the -stable repo.

Now applied, thanks.

greg k-h
