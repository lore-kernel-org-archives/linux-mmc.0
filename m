From: Edward Falk <Edward.Falk@palm.com>
Subject: Any work being done on MMC write protect?
Date: Wed, 10 Mar 2010 20:01:24 -0800
Message-ID: <4B986B14.6040304@palm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-relay2.palm.com ([64.28.152.243]:53265 "EHLO
	smtp-relay2.palm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756173Ab0CKELZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Mar 2010 23:11:25 -0500
Received: from peregrine.palm1.palmone.com (peregrine.palm1.palmone.com [148.92.213.4])
	by mailhost02.palm.com (8.13.6+Sun/8.12.10) with ESMTP id o2B3x9g8008589
	for <linux-mmc@vger.kernel.org>; Wed, 10 Mar 2010 19:59:10 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

I've written some ioctls (for the 2.6.29 kernel) which implement 
SEND_WRITE_PROT and SET_WRITE_PROT.  However I can't get them to work -- 
the former throws a CRC error and the latter returns success but doesn't 
actually write-protect the device.

I was wondering if anybody else had done any work in this area.

If anybody wants the code, I can send a patch along.

	-ed falk
