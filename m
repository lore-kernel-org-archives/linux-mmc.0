From: Harald Welte <laforge@gnumonks.org>
Subject: Re: [PATCH] mmc: via-sdmmc: Use module_pci_driver
Date: Mon, 27 Aug 2012 09:50:52 +0200
Message-ID: <20120827075052.GJ31372@prithivi.gnumonks.org>
References: <1346049731-21085-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:40531 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921Ab2H0IJe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Aug 2012 04:09:34 -0400
Content-Disposition: inline
In-Reply-To: <1346049731-21085-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, brucechang@via.com.tw, patches@linaro.org

Hi Sachin,

On Mon, Aug 27, 2012 at 12:12:11PM +0530, Sachin Kamat wrote:
> module_pci_driver makes the code simpler by eliminating
> module_init and module_exit calls.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Acked-by: Harald Welte <laforge@gnumonks.org>

-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
