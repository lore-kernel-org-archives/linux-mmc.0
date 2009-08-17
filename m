From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: RE: legal status of code derived from sdcard.org specs?
Date: Mon, 17 Aug 2009 12:12:11 -0400
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901BEA05D@mi8nycmail19.Mi8.com>
References: <4A860486.1030001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod6og101.obsmtp.com ([64.18.1.181]:55456 "HELO
	exprod6og101.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755677AbZHQQTU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Aug 2009 12:19:20 -0400
Content-class: urn:content-classes:message
In-Reply-To: <4A860486.1030001@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Don Mullis <don.mullis@gmail.com>, linux-mmc@vger.kernel.org

On Friday, August 14, 2009 5:43 PM, Don Mullis wrote:
> sdcard.org specs appear to not be (any longer) public.  When downloading 
> some today I had to give an employer's name, and received in return PDFs 
> watermarked with that name.
> 
> This is a practical issue for a couple of patches that I'd like to post 
> for review.  They extend the existing code that extracts the CSD and SCR 
> registers to extract as well an SD-specific register containing some 
> performance-related parameters.
> 
> Any ideas on how we might seek clarification?

On 7-29-09 Segher Boessenkool posted a message on linux-embedded that said
the following:

The MMC Association has merged with JEDEC, so now everyone can download
the specs, e.g. http://www.jedec.org/download/search/JESD84-A44.pdf .

Does that help?

Regards,
Hartley
