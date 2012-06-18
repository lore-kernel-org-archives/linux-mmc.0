From: Juan Carlos Garza Fernandez <juancarlosgarza@gmail.com>
Subject: Write Timeout is too long.
Date: Mon, 18 Jun 2012 16:45:17 +0200
Message-ID: <CAMEN=G4ucjXyE9O=PhJwtMMMjdXni1NYnScUkT66hhQ-QGG6Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:47875 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294Ab2FROpS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jun 2012 10:45:18 -0400
Received: by wibhm6 with SMTP id hm6so1720304wib.1
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jun 2012 07:45:17 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

On the past, the write timeout was increased from 300 ms to 3 seconds
(see commit 3bdc9ba892d6a294d16e9e6e0c4041926aa3d58c from Paul
Walmsley)  as some cards had issues with that limit, which is correct
as the issue can be reproduced by me. Increasing that timeout solves
the problem, however increasing the timeout to 3 seconds is a bit too
much and  following error message occurs in the kernel log:

 mmc1: Too large timeout requested for CMD25!

Empirically using 2 seconds for the 3.4.x kernel works fine. On a
2.6.24 kernel, the timeout was reduced to 1.5 s to avoid the message.

Can someone tell me on what basis was the timeout set to 3s? Was it
also empirically deduced?

Would it make sense to reduce the timeout?

Regards,
-- 
________________________________
Juan Carlos Garza
