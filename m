From: Roger <rogerable@realtek.com>
Subject: Re: [PATCH v5 3/3] memstick: Add realtek USB memstick host driver
Date: Tue, 1 Apr 2014 11:20:32 +0800
Message-ID: <533A3080.2020008@realtek.com>
References: <1395744293-24398-1-git-send-email-rogerable@realtek.com>
 <1395744293-24398-4-git-send-email-rogerable@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1395744293-24398-4-git-send-email-rogerable@realtek.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Chris Ball <chris@printf.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ulf Hansson <ulf.hansson@linaro.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: wei_wang@realsil.com.cn, driverdev-devel@linuxdriverproject.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 03/25/2014 06:44 PM, rogerable@realtek.com wrote:
> From: Roger Tseng <rogerable@realtek.com>
>
> Realtek USB memstick host driver provides memstick host support based on the
> Realtek USB card reader MFD driver.
>
> Signed-off-by: Roger Tseng <rogerable@realtek.com>
> ---
>   drivers/memstick/host/Kconfig       |  10 +
>   drivers/memstick/host/Makefile      |   1 +
>   drivers/memstick/host/rtsx_usb_ms.c | 839 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 850 insertions(+)
>   create mode 100644 drivers/memstick/host/rtsx_usb_ms.c
Hi Andrew,

Since I'll have to send next revision(v6, to modify patch 1/3) and 
you've commented v4, would you also comment or Ack the 3/3 of this one? 
This should save one revision for me to make any necessary change.
