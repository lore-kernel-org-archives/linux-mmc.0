From: Giacomo Comes <comes@naic.edu>
Subject: sd card not working on intel compute stick STK1AW32SC
Date: Mon, 31 Oct 2016 23:22:59 -0400
Message-ID: <20161101032259.GA12857@monopoli.naic.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailserver.naic.edu ([192.65.176.45]:55594 "EHLO
        mailserver.naic.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161553AbcKADol (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Oct 2016 23:44:41 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

I have a couple of cherryview PC.
One is a Acer Aspire R11 and the other is a
Intel compute stick STK1AW32SC
On the Acer Aspire, the mmc card reader works ok,
but on the compute stick it doesn't.
I'm running kernel 4.9rc3 and 
when I insert a mmc card I see this message in the journal:
  mmc1: error -84 whilst initialising SD card
whith another card instead I got this error message:
  mmc1: card never left bust state
  mmc1: error -110 whilst initialising SD card
Both sd cards work ok on other linux PC.

Can this be fixed?

Giacomo

