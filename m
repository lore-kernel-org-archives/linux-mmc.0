From: Dinh Nguyen <dinguyen@altera.com>
Subject: Re: [RESEND PATCHv8 3/4] mmc: dw_mmc-socfpga: Remove the SOCFPGA
 specific platform for dw_mmc
Date: Tue, 7 Jan 2014 18:15:47 -0600
Message-ID: <1389140147.26863.0.camel@linux-builds1>
References: <1389036754-7249-1-git-send-email-dinguyen@altera.com>
 <1389036754-7249-4-git-send-email-dinguyen@altera.com>
 <20140107201721.GK20094@book.gsilab.sittig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140107201721.GK20094@book.gsilab.sittig.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gerhard Sittig <gsi@denx.de>
Cc: devicetree@vger.kernel.org, dinh.linux@gmail.com, heiko@sntech.de, arnd@arndb.de, bzhao@marvell.com, tgih.jun@samsung.com, linux-mmc@vger.kernel.org, dianders@chromium.org, jh80.chung@samsung.com, alim.akhtar@samsung.com, zhangfei.gao@linaro.org, mturquette@linaro.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Gerhard,

On Tue, 2014-01-07 at 21:17 +0100, Gerhard Sittig wrote:
> On Mon, Jan 06, 2014 at 13:32 -0600, dinguyen@altera.com wrote:
> > 
> > ---
> >  drivers/mmc/host/Kconfig          |    8 ---
> >  drivers/mmc/host/dw_mmc-socfpga.c |  138 -------------------------------------
> >  2 files changed, 146 deletions(-)
> >  delete mode 100644 drivers/mmc/host/dw_mmc-socfpga.c
> 
> Isn't a Makefile affected when you remove a config option and the
> whole source file which depends on the option?  Running
> 
>   git grep MMC_DW_SOCFPGA
> 
> on v3.13-rc7-55-gef350bb7c5e0 suggests that
> drivers/mmc/host/Makefile needs an update as well.

Yes, thanks for catching that. Will fix in v9.

Dinh
> 
> 
> virtually yours
> Gerhard Sittig
