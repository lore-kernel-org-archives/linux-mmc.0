Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B342C1AE;
	Fri, 24 Nov 2023 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PXP9b/W1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C7BC433C7;
	Fri, 24 Nov 2023 15:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700838433;
	bh=AEn7eLNiCWXSCKU/V6dq487QCSOB2Gi18tMF4Q+T8s0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PXP9b/W1Cyy4ODd36Mg/WHH8md71tO7eh/829jn6datfyuRX9ObT54PQy6QRxih4U
	 A7CTFtzIEHRhaFg3z9xr9LOThevoGgvbebSyO/sG1L3fB+/bRNMaF+Rb9tlL2cMY/w
	 RlWR4eBfj4kAvgpR0VPTX5sidzngqyn71CUCF0P4=
Date: Fri, 24 Nov 2023 15:07:11 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 1/3] driver core: move core part of device_shutdown()
 to a separate function
Message-ID: <2023112450-unsterile-crushing-c665@gregkh>
References: <20231124145338.3112416-1-o.rempel@pengutronix.de>
 <20231124145338.3112416-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124145338.3112416-2-o.rempel@pengutronix.de>

On Fri, Nov 24, 2023 at 03:53:36PM +0100, Oleksij Rempel wrote:
> Split the device_shutdown() as a preparation for the prioritization
> support.

Nit, this is going to need a lot more description, as at this point in
time, we do not know what "prioritization support" is.

> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/base/core.c | 110 +++++++++++++++++++++++++-------------------
>  1 file changed, 63 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 67ba592afc77..0f5646a097d3 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4719,12 +4719,73 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
>  }
>  EXPORT_SYMBOL_GPL(device_change_owner);
>  
> +/**

This doesn't need kernel-doc for a static function, right?

> + * device_shutdown_one - shut down a device
> + * @dev: device to shut down
> + *
> + * It is called with the device lock held.
> + *
> + * The device must be on the devices_kset list.
> + */
> +static void device_shutdown_one_locked(struct device *dev)
> +{
> +	struct device *parent;
> +
> +	lockdep_assert_held(&devices_kset->list_lock);
> +	/*
> +	 * hold reference count of device's parent to
> +	 * prevent it from being freed because parent's
> +	 * lock is to be held
> +	 */
> +	parent = get_device(dev->parent);
> +	get_device(dev);
> +	/*

As you are moving the code, might as well make it a bit prettier and add
proper line breaks before the comments please.

thanks,

greg k-h
