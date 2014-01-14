From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 3/3] memstick: Add realtek USB memstick host driver
Date: Tue, 14 Jan 2014 11:19:53 +0300
Message-ID: <20140114081953.GG7499@mwanda>
References: <1389685656-880-1-git-send-email-rogerable@realtek.com>
 <1389685656-880-4-git-send-email-rogerable@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1389685656-880-4-git-send-email-rogerable@realtek.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: rogerable@realtek.com
Cc: Samuel Ortiz <sameo@linux.intel.com>, Alex Dubov <oakad@yahoo.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, driverdev-devel@linuxdriverproject.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, Chris Ball <cjb@laptop.org>, Lee Jones <lee.jones@linaro.org>, Maxim Levitsky <maximlevitsky@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, Jan 14, 2014 at 03:47:36PM +0800, rogerable@realtek.com wrote:
> +static int ms_pull_ctl_disable(struct rtsx_ucr *ucr)
> +{
> +	rtsx_usb_init_cmd(ucr);
> +
> +	if (CHECK_PKG(ucr, LQFP48)) {
> +		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD,
> +				CARD_PULL_CTL1, 0xFF, 0x55);
> +		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD,
> +				CARD_PULL_CTL2, 0xFF, 0x55);
> +		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD,
> +				CARD_PULL_CTL3, 0xFF, 0x95);
> +		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD,
> +				CARD_PULL_CTL4, 0xFF, 0x55);
> +		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD,
> +				CARD_PULL_CTL5, 0xFF, 0x55);
> +		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD,
> +				CARD_PULL_CTL6, 0xFF, 0xA5);
> +	} else {
> +		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD,
> +				CARD_PULL_CTL1, 0xFF, 0x65);
> +		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD,
> +				CARD_PULL_CTL2, 0xFF, 0x55);
> +		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD,
> +				CARD_PULL_CTL3, 0xFF, 0x95);
> +		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD,
> +				CARD_PULL_CTL4, 0xFF, 0x55);
> +		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD,
> +				CARD_PULL_CTL5, 0xFF, 0x56);
> +		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD,
> +				CARD_PULL_CTL6, 0xFF, 0x59);
> +	}
> +

I'm fine with this patch going in as-is, but I just wanted to comment on
this for future reference/cleanups.  These blocks where all the lines
are over 80 characters are hard to look at.  We could break it into
separate functions.

static int ms_pull_ctl_disable_lqfp48(struct rtsx_ucr *ucr)
{
	rtsx_usb_init_cmd(ucr);

	rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_PULL_CTL1, 0xFF, 0x55);
	rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_PULL_CTL2, 0xFF, 0x55);
	rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_PULL_CTL3, 0xFF, 0x95);
	rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_PULL_CTL4, 0xFF, 0x55);
	rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_PULL_CTL5, 0xFF, 0x55);
	rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_PULL_CTL6, 0xFF, 0xA5);

	return rtsx_usb_send_cmd(ucr, MODE_C, 100);
}

Or another option would be to remove the "CARD_" prefix.  I don't think
we would miss it.

	if (CHECK_PKG(ucr, LQFP48)) {
		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, PULL_CTL1, 0xFF, 0x55);
		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, PULL_CTL2, 0xFF, 0x55);
		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, PULL_CTL3, 0xFF, 0x95);
		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, PULL_CTL4, 0xFF, 0x55);
		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, PULL_CTL5, 0xFF, 0x55);
		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, PULL_CTL6, 0xFF, 0xA5);
	} else {
		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, PULL_CTL1, 0xFF, 0x65);
		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, PULL_CTL2, 0xFF, 0x55);
		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, PULL_CTL3, 0xFF, 0x95);
		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, PULL_CTL4, 0xFF, 0x55);
		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, PULL_CTL5, 0xFF, 0x56);
		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, PULL_CTL6, 0xFF, 0x59);
	}

Another option might be to remove the "_usb" from the
rtsx_usb_add_cmd().

Just some ideas.

regards,
dan carpenter
