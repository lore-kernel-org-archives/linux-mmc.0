From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v4 1/1]mmc: implemented eMMC4.4 enhanced area feature
Date: Sat, 22 Jan 2011 01:51:32 +0000
Message-ID: <20110122015132.GA6748@void.printf.net>
References: <20110121200941.GA16236@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110121200941.GA16236@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-mmc@vger.kernel.org

Hi Chuanxiao,

On Sat, Jan 22, 2011 at 04:09:41AM +0800, Chuanxiao Dong wrote:
> Enhanced area feature is a new feature defined in eMMC4.4 standard. This
> kind of area can help to improve the performance.
> 
> MMC driver will read out the enhanced area offset and size and add them
> to be device attributes. The feature enabling should be done in manufactory.
> To use this feature, bit ERASE_GRP_DEF should also be set.
> 
> Documentation/ABI/testing/sysfs-devices-mmc described the two new attributes
> 
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>

Looks good, pushed to mmc-next.  Thanks for all the edits to this!

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
