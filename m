From: Jon Ringle <jon@ringle.org>
Subject: dma changes causes SD card to fail detection
Date: Mon, 3 Mar 2014 01:56:45 -0500
Message-ID: <CAMwGMjxv4FFtn7Aysctr4AALqmHNn4KJYJZWRK5NA09NFDd5zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:57863 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbaCCG4q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Mar 2014 01:56:46 -0500
Received: by mail-lb0-f179.google.com with SMTP id p9so4008751lbv.24
        for <linux-mmc@vger.kernel.org>; Sun, 02 Mar 2014 22:56:45 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: joelf@ti.com, vinod.koul@intel.com
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

I am porting an arm board from linux-3.10 to linux-3.12 and found that
on linux-3.12 I was no longer able to detect the SD card on the board.
I found that the wait_for_completion(&mrq->completion) call in
drivers/mmc/core/core.c:mmc_wait_for_done() was never returning.

I was able to bisect the problem to the following commit. Could you
please advise as to what to do to resolve this issue?

  534070622d2c7fbc5cc929aa93541ccd0ae52ab1 is the first bad commit
  commit 534070622d2c7fbc5cc929aa93541ccd0ae52ab1
  Author: Joel Fernandes <joelf@ti.com>
  Date:   Tue Sep 3 10:02:46 2013 -0500

      dma: edma: Write out and handle MAX_NR_SG at a given time

      Process SG-elements in batches of MAX_NR_SG if they are greater
      than MAX_NR_SG. Due to this, at any given time only those many
      slots will be used in the given channel no matter how long the
      scatter list is. We keep track of how much has been written
      inorder to process the next batch of elements in the scatter-list
      and detect completion.

      For such intermediate transfer completions (one batch of MAX_NR_SG),
      make use of pause and resume functions instead of start and stop
      when such intermediate transfer is in progress or completed as we
      donot want to clear any pending events.

      Signed-off-by: Joel Fernandes <joelf@ti.com>
      Signed-off-by: Vinod Koul <vinod.koul@intel.com>


I tried reverting this commit, but this results in the compiler
complaining with the following:

drivers/dma/edma.c: In function 'edma_execute':
drivers/dma/edma.c:155:11: error: 'struct edma_desc' has no member
named 'processed'
  if (edesc->processed == edesc->pset_nr)
           ^
drivers/dma/edma.c:156:25: error: 'nslots' undeclared (first use in
this function)
   edma_link(echan->slot[nslots-1], echan->ecc->dummy_slot);
                         ^
drivers/dma/edma.c:156:25: note: each undeclared identifier is
reported only once for each function it appears in
drivers/dma/edma.c: At top level:
drivers/dma/edma.c:166:2: error: expected identifier or '(' before 'if'
  if (echan->missed) {
  ^

Thanks,
Jon
