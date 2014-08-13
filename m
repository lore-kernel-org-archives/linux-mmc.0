From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] mmc: rtsx: fix incorrect last byte in R2 response
Date: Wed, 13 Aug 2014 11:50:24 +0300
Message-ID: <20140813085024.GQ11899@mwanda>
References: <1407745936-18513-1-git-send-email-rogerable@realtek.com>
 <20140811130254.GP4856@mwanda> <53E9BFF0.5030506@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <53E9BFF0.5030506@realtek.com>
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, driverdev-devel@linuxdriverproject.org, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn
List-Id: linux-mmc@vger.kernel.org

On Tue, Aug 12, 2014 at 03:19:12PM +0800, Roger wrote:
> I can remove the unused rsp_len in this function. But I'm afraid the
> loop is still required. The destination cmd->resp is cpu-endian, but
> the raw response from SD card in the buffer (pointed by ptr) is
> big-endian.

Oh, yes.  Of course.  Sorry for the noise.

regards,
dan carpenter
