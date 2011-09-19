From: Andrei Warkentin <awarkentin@vmware.com>
Subject: Re: [PATCH] mmc : export hw reset function info to user
Date: Mon, 19 Sep 2011 09:19:48 -0700 (PDT)
Message-ID: <108743536.474964.1316449188347.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
References: <1316359225-2224-1-git-send-email-linkinjeon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-outbound-1.vmware.com ([65.115.85.69]:31769 "EHLO
	smtp-outbound-1.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756381Ab1ISQTs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Sep 2011 12:19:48 -0400
In-Reply-To: <1316359225-2224-1-git-send-email-linkinjeon@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Namjae Jeon <linkinjeon@gmail.com>
Cc: linux-kernel@vger.kernel.org, cjb@laptop.org, linux-mmc@vger.kernel.org

Hi Namjae, others,

----- Original Message -----
> From: "Namjae Jeon" <linkinjeon@gmail.com>
> To: cjb@laptop.org, linux-mmc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org, "Namjae Jeon" <linkinjeon@gmail.com>
> Sent: Sunday, September 18, 2011 11:20:25 AM
> Subject: [PATCH] mmc : export hw reset function info to user
> 
> user app should know whether hw reset function is enable to use it.
> so I try to add sysfs file of hw reset function like enhanced area.
> 

If we're going to be adding a bunch of attributes from ext_csd, why not
just allow dumping the entire ext_csd in a semi-readable form? Via something like 
hex_dump_to_buffer. This will allow easy human an machine parsing, and be more 
lightweight then adding a sysfs attr for each EXT_CSD byte (of which there are a lot).

I'm basing this on the thought that the only clients of these attrbutes would
either be developers or engineers involved with MMC media, or very specialized
software.

Thoughts?

A
