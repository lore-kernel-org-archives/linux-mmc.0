From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] irq: If an IRQ is a GPIO,
	request and configure it
Date: Fri, 5 Aug 2011 09:01:50 +0900
Message-ID: <20110805000148.GB13321@opensource.wolfsonmicro.com>
References: <1312498820-2275-1-git-send-email-swarren@nvidia.com>
	<1312498820-2275-2-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1312498820-2275-2-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: alsa-devel@alsa-project.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, ccross@android.com, olof@lixom.net, Thomas Gleixner <tglx@linutronix.de>, Chris Ball <cjb@laptop.org>, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Aug 04, 2011 at 05:00:18PM -0600, Stephen Warren wrote:

> +	} else {
> +		gpio = irq_to_gpio(irq);
> +		if (gpio_is_valid(gpio)) {
> +			ret = gpio_request(gpio, new->name);
> +			if (ret < 0)
> +				goto out_mask;
> +			ret = gpio_direction_input(gpio);
> +			if (ret < 0)
> +				goto out_mask;
> +		}

If you treat failures as an error what happens when a driver is using a
GPIO as both an interrupt and a GPIO?  For example a driver which
monitors the level on a GPIO and uses edge triggered IRQs to be notified
of state changes.
