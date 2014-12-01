From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2 1/2] mfd: rtsx: add func to split u32 into register
Date: Mon, 1 Dec 2014 15:37:41 +0300
Message-ID: <20141201123740.GF4994@mwanda>
References: <cover.1417141102.git.micky_ching@realsil.com.cn>
 <6a6de978f479758fb9e767d8a6e013e8a006a39a.1417141102.git.micky_ching@realsil.com.cn>
 <20141201121858.GA11932@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <20141201121858.GA11932@x1>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Lee Jones <lee.jones@linaro.org>
Cc: ulf.hansson@linaro.org, sameo@linux.intel.com, gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, chris@printf.net, wei_wang@realsil.com.cn, devel@linuxdriverproject.org, rogerable@realtek.com
List-Id: linux-mmc@vger.kernel.org

On Mon, Dec 01, 2014 at 12:18:58PM +0000, Lee Jones wrote:
> On Fri, 28 Nov 2014, micky_ching@realsil.com.cn wrote:
> 
> > From: Micky Ching <micky_ching@realsil.com.cn>
> > 
> > Add helper function to write u32 to registers, if we want to put u32
> > value to 4 continuous register, this can help us reduce tedious work.
> > 
> > Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>
> > ---
> >  include/linux/mfd/rtsx_pci.h | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> 
> Does this supersede patch Dan was commenting on?
> 

Yes.

regards,
dan carpenter
