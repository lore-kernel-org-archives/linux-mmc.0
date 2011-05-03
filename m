From: "Gao, Yunpeng" <yunpeng.gao@intel.com>
Subject: Is it possible for the ext4/btrfs file system to pass some context
 related info to low level block driver?
Date: Tue, 3 May 2011 10:44:07 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A47358E28022@shsmsx501.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21284 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753562Ab1ECCoi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 May 2011 22:44:38 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Currently, some new storage devices have the ability to do performance optimizations according to the type of data payload - say, file system metadata, time-stamps, sequential write in some granularity, random write and so on.

For example, the latest eMMC 4.5 device can support the so-called 'Context Management' and 'Data Tag Mechanism' features. By receiving the information of payload data type, the eMMC 4.5 device can improve the access rate during the following read and update operations and offer a more reliable and robust storage.

And obviously, to enable these kind of advanced features of storage device, it needs not only the low level block device driver supports, but also the file system supports since files system knows more info about the data type of the payload. But currently, seems there are no file systems implemented these kind of supports yet.

So, my question is, is there any plan or discussion on supporting this feature (passing data type info to low level block device driver) on file system developments? Especially for ext4/btrfs, since now they are very hot in Linux? Thanks.


Regards,
Yunpeng Gao
