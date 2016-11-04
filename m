From: Giacomo Comes <comes@naic.edu>
Subject: Re: sd card not working on intel compute stick STK1AW32SC
Date: Fri, 4 Nov 2016 09:15:44 -0400
Message-ID: <20161104131544.GA14872@monopoli.naic.edu>
References: <20161101032259.GA12857@monopoli.naic.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailserver.naic.edu ([192.65.176.45]:60398 "EHLO
        mailserver.naic.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933226AbcKDNPs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Nov 2016 09:15:48 -0400
Content-Disposition: inline
In-Reply-To: <20161101032259.GA12857@monopoli.naic.edu>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Giacomo Comes <comes@naic.edu>
Cc: linux-mmc@vger.kernel.org

Hi,
apparently this in not the correct place to report the
mmc issue I'm having. Could at least anybody tell me
where I can find somebody who can investigate the problem?

Giacomo

On Mon, Oct 31, 2016 at 11:22:59PM -0400, Giacomo Comes wrote:
> I have a couple of cherryview PC.
> One is a Acer Aspire R11 and the other is a
> Intel compute stick STK1AW32SC
> On the Acer Aspire, the mmc card reader works ok,
> but on the compute stick it doesn't.
> I'm running kernel 4.9rc3 and 
> when I insert a mmc card I see this message in the journal:
>   mmc1: error -84 whilst initialising SD card
> whith another card instead I got this error message:
>   mmc1: card never left bust state
>   mmc1: error -110 whilst initialising SD card
> Both sd cards work ok on other linux PC.
> 
> Can this be fixed?
> 
> Giacomo
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
