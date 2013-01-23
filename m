From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v4 0/8] rtsx patchset for MFD and MMC tree
Date: Wed, 23 Jan 2013 10:21:22 +0300
Message-ID: <20130123072121.GY4584@mwanda>
References: <cover.1357638064.git.wei_wang@realsil.com.cn>
 <50F66CAD.6090003@realsil.com.cn>
 <20130122033115.GY7409@sortiz-mobl>
 <50FE09DD.6070102@realsil.com.cn>
 <20130122224232.GC5151@sortiz-mobl>
 <50FF3BAD.4010009@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <50FF3BAD.4010009@realsil.com.cn>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel/>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: "devel" <devel-bounces@linuxdriverproject.org>
To: pclinux <pclinux@realsil.com.cn>
Cc: "oakad@yahoo.com" <oakad@yahoo.com>, Samuel Ortiz <sameo@linux.intel.com>, "arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?utf-8?B?546L54Kc?= <wei_wang@realsil.com.cn>, "bp@alien8.de" <bp@alien8.de>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "cjb@laptop.org" <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jan 23, 2013 at 09:23:57AM +0800, pclinux wrote:
> Sure. I will do it.
> Does it mean that the other commits only can be submitted to 3.9-rc?
> 

Submit them now.  They stay in Samuel's tree and are tested in
linux-next until 3.8 is released.  Then Samuel submits them during
the 3.9 merge window.

The merge window is for Samuel => Linus, it's not for you => Samuel.
If your code has not reached Samuel's tree before 3.8 has been
released then it's too late and it will be delayed for another few
months.

regards,
dan carpenter
