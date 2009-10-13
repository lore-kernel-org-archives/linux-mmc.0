From: "Johnson, Charles F" <charles.f.johnson@intel.com>
Subject: RFC: Shared eMMC Controller
Date: Tue, 13 Oct 2009 08:38:06 -0700
Message-ID: <0D4616E6925F9541919B60692F61509E43AAA2A7@orsmsx502.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:9608 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753070AbZJMPin convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Oct 2009 11:38:43 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

I'm working on a system where we have a need to share the eMMC host controller with both the main CPU and a micro-controller.  So to coodinate access we need to define a mutex mechanism between the two.  This is possible since there is some shared non-cachable static ram that both have access to.  My question for this email list is, if we limit the mmc driver changes to use the chipset specific quirk mechanism, would that be acceptable ?? 

As soon as we have the code, we'll post it, but I am interested in any comments. 

Thanks.

Charles Johnson
Intel Corp.
charles.f.johnson@intel.com

 
