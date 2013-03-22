From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdio: bind acpi with sdio function device
Date: Fri, 22 Mar 2013 12:27:11 -0400
Message-ID: <87boabpfhc.fsf@octavius.laptop.org>
References: <1362453892-13304-1-git-send-email-aaron.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1362453892-13304-1-git-send-email-aaron.lu@intel.com> (Aaron
	Lu's message of "Tue, 5 Mar 2013 11:24:52 +0800")
Sender: linux-pm-owner@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-mmc@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi Aaron,

On Mon, Mar 04 2013, Aaron Lu wrote:
> ACPI spec 5 defined the _ADR encoding for sdio bus as:
> High word - slot number (0 based)
> Low word  - function number
>
> This patch adds support for binding sdio function device with acpi node,
> and if successful, involve acpi into its power management.
>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
