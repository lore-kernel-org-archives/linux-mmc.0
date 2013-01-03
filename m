From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v3 3/8] MFD:rtsx: Declare that the DMA address limitation
 is 32bit explicitly
Date: Thu, 3 Jan 2013 15:25:59 +0300
Message-ID: <20130103122559.GF7247@mwanda>
References: <cover.1356662293.git.wei_wang@realsil.com.cn>
 <cd92be49bee917165009311d62e10a5f60a85a48.1356662293.git.wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cd92be49bee917165009311d62e10a5f60a85a48.1356662293.git.wei_wang@realsil.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: wei_wang@realsil.com.cn
Cc: cjb@laptop.org, sameo@linux.intel.com, arnd@arndb.de, oakad@yahoo.com, gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de, devel@linuxdriverproject.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Dec 28, 2012 at 10:41:28AM +0800, wei_wang@realsil.com.cn wrote:
> From: Wei WANG <wei_wang@realsil.com.cn>
> 
> Realtek PCIe card reader only supports 32bit DMA
> 

Is this a bugfix?  If so what does the bug look like?

regards,
dan carpenter
