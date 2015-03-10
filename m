From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sleep notification
Date: Tue, 10 Mar 2015 15:36:14 +0200
Message-ID: <54FEF34E.20205@intel.com>
References: <1425980197-823-1-git-send-email-avi.shchislowski@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:64948 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751376AbbCJNiM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 Mar 2015 09:38:12 -0400
In-Reply-To: <1425980197-823-1-git-send-email-avi.shchislowski@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Avi Shchislowski <avi.shchislowski@sandisk.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, chris@printf.net, Alex.Lemberg@sandisk.com

On 10/03/15 11:36, Avi Shchislowski wrote:
> This patch is implements the new additional state of
> Power_Off_Notification =96 SLEEP_NOTIFICATION.
> Until now, the implementation of Power_Off_Notification
> supported only three modes =96 POWERED_ON (0x01),
> POWER_OFF_SHORT (0x02) and POWER_OFF_LONG (0x03).
>=20
> As part of eMMC5.0 before moving to Sleep state hosts may set the
> POWER_OFF_NOTIFICATION byte to SLEEP_NOTIFICATION (0x04).
> After setting SLEEP_NOTIFICATION, host should wait for
> the busy line to be de-asserted.
> The max timeout allowed for busy line de-assertion defined
> in SLEEP_NOTIFICATION_TIME byte in EXT_CSD [216].
> HPI may interrupt the SLEEP_NOTIFICATION operation.
> In that case POWER_OFF_NOTIFICATION byte will restore to POWERED_ON.

Is it so that the point of SLEEP_NOTIFICATION is to notify that
VCC will be powered off after the device is put to sleep by CMD5?

At the moment, the card does not get put to sleep if there is
support for power-off-notification?

