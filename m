From: Benjamin Beckmeyer <beckmeyer.b@rittal.de>
Subject: MMC flash is very slow since 4.14 - "mmc: Delete bounce buffer handling" was
 the problem
Date: Tue,  2 Jan 2018 10:10:37 +0100 (CET)
Message-ID: <OF8C6780FA.78E4ECBE-ONC1258209.003268EF-C1258209.003268F0@rittal.de>
Mime-Version: 1.0
Content-Type: text/plain;
        charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw03.loh-group.com ([195.226.74.51]:59242 "EHLO
        mailgw03.loh-group.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750979AbeABJKj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Jan 2018 04:10:39 -0500
Received: from mailgw03.loh-group.com (mailgw03.loh-group.com [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AEE3B48007
        for <linux-mmc@vger.kernel.org>; Tue,  2 Jan 2018 10:10:37 +0100 (CET)
Received: from notesroot2.de.flg.int (rootserver2.de.flg.int [10.201.6.141])
        by mailgw03.loh-group.com (Postfix) with ESMTP id 9A2CA48002
        for <linux-mmc@vger.kernel.org>; Tue,  2 Jan 2018 10:10:37 +0100 (CET)
In-Reply-To: 
References: 
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hey all,

I have a problem with mmc flash on an i.mx 25 architecture. Im running it with Linux 4.14.x and the flash is really slow.  
I digged a little bit deeper into this problem and it has nothing to do with the driver (sdhci-esdhci-imx.c), because all registers for the SDHCI have the same values in a kernel before 4.14 and in the current 4.14 kernel.

I figured out that following commit "mmc: Delete bounce buffer handling"  is the problem. I compiled my kernel without that patch and everything is running fine. There is a patch "mmc: sdhci: Avoid swiotlb buffer being full" and  I hoped this will fix the problem but it doesn't.. But maybe it doesn't fixed it for the imx driver. 

Hopefully anybody can help me with this problem. But I thought somebody with a better understanding of the mmc core components knows how to handle this problem (maybe somebody from linaro, because the two patches come from them).

Kind regards,
Benjamin
