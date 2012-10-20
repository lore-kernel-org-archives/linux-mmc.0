From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v6 0/3] Add modules to support realtek PCIE card reader
Date: Sat, 20 Oct 2012 06:46:15 +0300
Message-ID: <20121020034615.GT5685@mwanda>
References: <cover.1347330871.git.wei_wang@realsil.com.cn>
 <50664814.30407@turmel.org> <20120929110730.GA27797@liondog.tnic>
 <87d315osjm.fsf@octavius.laptop.org>
 <20120929152942.GA11412@liondog.tnic>
 <506FDC8C.3030707@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <506FDC8C.3030707@realsil.com.cn>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel/>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: "devel" <devel-bounces@linuxdriverproject.org>
To: wwang <wei_wang@realsil.com.cn>
Cc: Phil Turmel <philip@turmel.org>, sameo@linux.intel.com, arnd@arndb.de, gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, devel@linuxdriverproject.org, Andrew Morton <akpm@linux-foundation.org>, Chris Ball <cjb@laptop.org>, oakad@yahoo.com
List-Id: linux-mmc@vger.kernel.org

On Sat, Oct 06, 2012 at 03:23:56PM +0800, wwang wrote:
> We are still maintaining the SCSI driver for Realtek card reader,
> and will release the latest source code in the Github in the future.
> But maybe we won't push it to the staging tree any more.

Maybe we should just remove the staging code if it won't be fixed.
That's sort of the point of staging.

regards,
dan carpenter
