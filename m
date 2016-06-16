From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH] [V2] mmc: mmci: add missing include of mmci_qcom_dml.h
Date: Thu, 16 Jun 2016 19:35:06 +0100
Message-ID: <b0ac5e58-3875-f949-2f29-5cf7812cbd55@codethink.co.uk>
References: <1466101965-25568-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:54490 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512AbcFPSfL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jun 2016 14:35:11 -0400
In-Reply-To: <1466101965-25568-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@lists.codethink.co.uk
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infadead.org

On 16/06/16 19:32, Ben Dooks wrote:
> Fix the missing declarations of dml_start_xfer() and
> dml_hw_init() by including mmci_qcom_dml.h to fix the
> following warnings:
> 
> drivers/mmc/host/mmci_qcom_dml.c:57:6: warning: symbol 'dml_start_xfer' was not declared. Should it be static?
> drivers/mmc/host/mmci_qcom_dml.c:122:5: warning: symbol 'dml_hw_init' was not declared. Should it be static?
> 
> Since the module build doesn't export symbols, also
> export the symbols from the mmci_qcom_dml.c file as
> otherwise the module link process won't work.
> 
> Note, since this is a very small addition to the mmci
> module, it would better to build it into the main mmci
> driver (either by direct copy, or multiple linked
> module)

I've also noted the driver doesn't have any MODULE_LICENSE or
MODULE_AUTHOR fields in it.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
