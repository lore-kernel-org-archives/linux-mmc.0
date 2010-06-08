From: "Johnson, Charles F" <charles.f.johnson@intel.com>
Subject: RFC: Adding HPI to prioritize Reads or Writes
Date: Tue, 8 Jun 2010 11:14:00 -0700
Message-ID: <0D4616E6925F9541919B60692F61509E67517A6F@orsmsx502.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8935 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752675Ab0FHSNP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jun 2010 14:13:15 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Folks - I'm wondering what this list thinks of making a change to the mmc driver to make use the the High Priority Interrupt (HPI) feature that was added in the eMMC 4.41 spec to give priority to reads over writes.  Part of this could be writing a custom i/o scheduler that just resorts the requests on the queue so that reads are always favored.  (And obviously taking into account where a read is dependent on a previous write.)  But the secondary ideas is to use HPI to interrupt a write in progress as long as the incoming read isn't depending on the write.  Then the write would have to finished later, I guess.  So my question for this list is, is this even feasible ??  Only the i/o scheduler knows if of incoming reads.  The driver itself just knows about the current request.  Does the i/o s
 cheduler know what request is in progress ??  (CFQ scheduler for example.)

Charles Johnson
Ultra-Mobility Group
UMSE Software Architecture
Intel Corporation
charles.f.johnson@intel.com
 
