From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: Query on SDHCI ACPI
Date: Mon, 9 Jan 2017 10:57:58 +0200
Message-ID: <d83bb4d6-d1fc-7f30-f8a0-f2ce5f067df7@intel.com>
References: <MWHPR12MB1357F3294B83542862BF18E5A0600@MWHPR12MB1357.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:5933 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757599AbdAIJDP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 9 Jan 2017 04:03:15 -0500
In-Reply-To: <MWHPR12MB1357F3294B83542862BF18E5A0600@MWHPR12MB1357.namprd12.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>

On 05/01/17 17:27, Shah, Nehal-bakulchandra wrote:
> Currently I am focusing on future EMMC Controller for AMD Platform. This
> controller is EMMC 5.0 based ACPI device in our system. As I can see the
> code in mmc driver sdhci-acpi.c supports acpi enumerated EMMC controller.
> As per my understanding I need to update device id for AMD Controller in
>  sdhci_acpi_uids  table and sdhci_acpi_ids table. That apart do I have to
> write separate platform driver interface? If yes, what is exactly
> required to be done, we have acpi to platform interface file at 
> drivers\acpi\acpi_apd.c (like lpss of intel) so can we leverage the
> same? Also Anything to do related to mmc binding?

If your host controller is enumerated by ACPI and follows the SDHCI
specification as implemented by drivers/mmc/host/sdhci.c then adding the HID
to sdhci_acpi_uids and sdhci_acpi_ids should enable it.

Note that sdhci-acpi is a driver for the compatibility ID "PNP0D40" which is
used for host controllers that follow the SDHCI specification.  That means
if your ACPI device node includes _CID of "PNP0D40" then it will already be
probed by sdhci-acpi.

On the other hand, if your device does not follow SDHCI very well you might
be better off avoiding "PNP0D40" and writing your own driver.
