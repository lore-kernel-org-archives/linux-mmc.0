From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 3/3] memstick: Add realtek USB memstick host driver
Date: Thu, 20 Mar 2014 16:19:20 -0700
Message-ID: <20140320161920.256afa8c21ac8f28e6c029b5@linux-foundation.org>
References: <1392199238-14500-1-git-send-email-rogerable@realtek.com>
 <1392199238-14500-4-git-send-email-rogerable@realtek.com>
 <532AA8EB.3010206@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <532AA8EB.3010206@realtek.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Roger <rogerable@realtek.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Alex Dubov <oakad@yahoo.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, driverdev-devel@linuxdriverproject.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, Chris Ball <cjb@laptop.org>, Lee Jones <lee.jones@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>, Maxim Levitsky <maximlevitsky@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, 20 Mar 2014 16:38:03 +0800 Roger <rogerable@realtek.com> wrote:

> On 02/12/2014 06:00 PM, rogerable@realtek.com wrote:
> > From: Roger Tseng <rogerable@realtek.com>
> >
> > Realtek USB memstick host driver provides memstick host support based on the
> > Realtek USB card reader MFD driver.
> >
> > Signed-off-by: Roger Tseng <rogerable@realtek.com>
> Andrew,
> 
> Would you please Ack or comment this patch(3/3) to let the 3 patches be 
> merged together? I have been making the same request at the message 
> thread of "[PATCH v4 2/3]" since several weeks ago but got no response. 
> Thus I re-post here and hope I could get something.
> 

Looks OK to me - I had a few minor quibbles.  Please proceed in that
way.

It would be nice if Alex and/or Maxim had time to look through the code.
