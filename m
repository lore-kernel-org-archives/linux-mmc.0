From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [PATCH] mmc: eMMC signal voltage does not use CMD11
Date: Tue, 26 Apr 2011 12:10:20 -0500
Message-ID: <6C03668EAF45B747AF947A1603D1B300EB72D7FA@SAUSEXMBP01.amd.com>
References: <ABE44455-4F1B-45A2-AED9-150C8E5DBED0@marvell.com>
 <6C03668EAF45B747AF947A1603D1B300EB72D36F@SAUSEXMBP01.amd.com>
 <390DC252-295C-4B82-8D5F-43E92EA5D3AF@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:35890
	"EHLO VA3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754872Ab1DZRKa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 26 Apr 2011 13:10:30 -0400
In-Reply-To: <390DC252-295C-4B82-8D5F-43E92EA5D3AF@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Philip,

[...]

> >> -	if (signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
> >> +	if (signal_voltage != MMC_SIGNAL_VOLTAGE_330 && cmd11) {
> >
> > Since we are going to send CMD11 only to change to 1.8V signaling,
> and when cmd11 is set, isn't it better to have
> >
> > 	if ((signal_voltage == MMC_SIGNAL_VOLTAGE_180) && cmd11) {
> 
> I am okay with this.  Wanted to cover the possible future case for 1.2V
> support and CMD11.  I know eMMC does not do
> CMD11 but incase SD or SDIO ever did.   If you feel strongly will
> change code.

If you think that 1.2V might need CMD11, I am okay with your change.

Thanks,
Arindam


