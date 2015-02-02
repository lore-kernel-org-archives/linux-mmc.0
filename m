From: =?UTF-8?B?U8OpYmFzdGllbiBCb3VyZGVhdWR1Y3E=?= <sb@m-labs.hk>
Subject: Re: "Timeout waiting for hardware interrupt" on Lenovo Thinkpad Tablet
 10
Date: Mon, 02 Feb 2015 22:06:55 +0800
Message-ID: <54CF847F.3070800@m-labs.hk>
References: <54CF7DCB.8070302@kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ssl.serverraum.org ([88.198.40.39]:49014 "EHLO
	ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754632AbbBBOL6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Feb 2015 09:11:58 -0500
In-Reply-To: <54CF7DCB.8070302@kit.edu>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Simon Raffeiner (SCC)" <simon.raffeiner@kit.edu>
Cc: linux-mmc@vger.kernel.org

On 02/02/2015 09:38 PM, Simon Raffeiner (SCC) wrote:
> I am currently trying to install Ubuntu 15.04

Another bug with the Ubuntu installer on this pesky computer is it
attempts to access the rpmb partition, fails, and aborts the
installation. For some reason, debug_quirks2=3D0xc0 also works around t=
his
problem.

> the tablet also crashes if the eMMC storage is not used as the
> root filesystem, it also happens in the live environment booted off t=
he
> USB stick, e.g. when trying to do an mkfs on one of the eMMC partitio=
ns.

I also experienced freezes when booted from a Arch Linux USB stick
(2015.01.01 with 3.17.6 kernel), and I gave up and went for Ubuntu wher=
e
strangely enough those crashes did not happen. I don't know if they are
related to the eMMC as I was not able to get any kernel message (the
machine simply stops responding completely).

S=C3=A9bastien

