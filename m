From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 3/3] mmc: sdhci-acpi: add SDHCI ACPI driver
Date: Fri, 23 Nov 2012 11:44:06 +0200
Message-ID: <20121123094406.GS3867@intel.com>
References: <1353573830-13006-1-git-send-email-adrian.hunter@intel.com>
 <1353573830-13006-4-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:30368 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759092Ab2KWJkt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 23 Nov 2012 04:40:49 -0500
Content-Disposition: inline
In-Reply-To: <1353573830-13006-4-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Nov 22, 2012 at 10:43:50AM +0200, Adrian Hunter wrote:
> +static int __devinit sdhci_acpi_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	acpi_handle handle = dev->acpi_handle;

This is not going to work anymore, you'll have to use ACPI_HANDLE(dev) for
this (there was a new macro introduced with the struct acpi_dev_node).

> +	struct acpi_device *device;
> +	struct sdhci_acpi_host *c;
> +	struct sdhci_host *host;
> +	struct resource *iomem;
> +	resource_size_t len;
> +	const char *hid;
> +	int err;
> +
> +	if (acpi_bus_get_device(handle, &device))
> +		return -ENODEV;
> +
> +	if (acpi_bus_get_status(device) || !device->status.present)
> +		return -ENODEV;

This is a bit redundant as the platform code already checks whether the
device is present or not and only creates the platform device in case it is
present.
