From: "Minjian Wu (minjianwu)" <minjianwu@micron.com>
Subject: eMMC bus test command failure
Date: Mon, 27 May 2013 01:12:49 +0000
Message-ID: <59606D77376AA44BB2E289FE5BA55046751CFA84@NTXXIAMBX01.xacn.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout.micron.com ([137.201.242.129]:60174 "EHLO
	mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755619Ab3E0BMy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 May 2013 21:12:54 -0400
Received: from mail.micron.com (ntxboicas02.micron.com [137.201.20.138])
	by mailout.micron.com (8.13.6/8.13.6) with ESMTP id r4R1CrJv019518
	for <linux-mmc@vger.kernel.org>; Sun, 26 May 2013 19:12:53 -0600
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,
=A0=A0=A0=A0
	I got one issue on Linux V3.7 as following.
=A0=A0=A0=A0=A0=A0=A0=A0 > mmc0: switch to bus width 1 ddr 0 failed=20
=A0=A0=A0=A0=A0=A0=A0=A0=A0> mmc0: error -110 whilst initialising MMC c=
ard

=A0=A0=A0=A0=A0=A0=A0=A0=A0After debugging and checking the source code=
s, we find that in mmc_send_bus_test function, there is no data timeout=
 setting(mmc_set_data_timeout). After we add the timeout setting functi=
on, this issue is fixed, could you help confirm it? Thank you!




Best Regards,=20

