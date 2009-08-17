From: Don Mullis <don.mullis@gmail.com>
Subject: Re: legal status of code derived from sdcard.org specs?
Date: Mon, 17 Aug 2009 14:49:09 -0700
Message-ID: <6657d10e0908171449l6961e65ek76e33a94154de7c4@mail.gmail.com>
References: <4A860486.1030001@gmail.com> <4A8840AC.5050204@mnementh.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f196.google.com ([209.85.216.196]:54482 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758099AbZHQVtH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Aug 2009 17:49:07 -0400
Received: by pxi34 with SMTP id 34so1405160pxi.4
        for <linux-mmc@vger.kernel.org>; Mon, 17 Aug 2009 14:49:09 -0700 (PDT)
In-Reply-To: <4A8840AC.5050204@mnementh.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: linux-mmc@vger.kernel.org

On 8/16/09, Ian Molton <ian@mnementh.co.uk> wrote:
> Don Mullis wrote:
>> sdcard.org specs appear to not be (any longer) public.  When downloading
>> some today I had to give an employer's name, and received in return PDFs
>> watermarked with that name.
>
> If you can put in any name, and they dont verify it, I cant imagine they
> can claim the specs are private.

A bit more Googling has turned up the "SD Simplified Specification",
publicly available from:

    http://www.sdcard.org/developers/tech/sdcard/pls/

This doc does describe the SD_STATUS register -- so I will post my patches.
