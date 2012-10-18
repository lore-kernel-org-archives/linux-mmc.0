From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC PATCH 3/4] sdio: introduce sdio_platform_pm_ops
Date: Fri, 19 Oct 2012 01:30:37 +0200
Message-ID: <2652168.I0b0faFkoR@vostro.rjw.lan>
References: <1350011561-21039-1-git-send-email-aaron.lu@intel.com> <1350011561-21039-4-git-send-email-aaron.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:53733 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932833Ab2JRX0w (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 18 Oct 2012 19:26:52 -0400
In-Reply-To: <1350011561-21039-4-git-send-email-aaron.lu@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

On Friday 12 of October 2012 11:12:40 Aaron Lu wrote:
> Some platform has the ability to set the sdio device into a low power
> state with some specific method, e.g. ACPI on x86 based system can use
> acpi control methods to change the device's power state.
> 
> Considering there may be different platforms utilizing different
> mechanisms to achieve this, a new structure is introduced to let
> individual platform to use these callbacks to do the job.
> 
> The structure contains 4 callbacks:
> - is_manageable
>   return true when the platform can manage the device's power;
>   return false otherwise.
> - choose_state
>   Choose a proper power state for the device
> - set_state
>   Set the device's power state
> - run_wake
>   Enable the device's runtime wakeup capability from the platform's
>   perspective.
> 
> And 4 functions to wrap these callbacks:
> - bool platform_sdio_power_manageable(struct device *dev)
> - int platform_sdio_choose_power_state(struct device *dev)
> - int platform_sdio_set_power_state(struct device *dev, int state)
> - int platform_sdio_run_wake(struct device *dev, bool enable)
> So when these callbacks are desired, these wrapper functions should be
> used. And if someday some sdio function driver which lives out of the
> mmc subsystem has a need to use these wrapper functions, they can be
> exported.
> 
> sdio_acpi.c implements these callbacks utilizing ACPI code.
> 
> The idea of this patch and the definition/wrapper of these callbacks
> are heavily based on the one used in PCI subsystem.
> 
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>

I'm not really sure if we need to make it so complicated.

Please see my comments on the next patch.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
