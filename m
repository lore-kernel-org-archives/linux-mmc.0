From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 0/7] fix build failure of mn10300
Date: Thu, 18 Jun 2015 15:51:38 +0100
Message-ID: <20150618145138.GN7557@n2100.arm.linux.org.uk>
References: <1434629873-11668-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:40505 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754439AbbFROvv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Jun 2015 10:51:51 -0400
Content-Disposition: inline
In-Reply-To: <1434629873-11668-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-am33-list@redhat.com, linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Thu, Jun 18, 2015 at 05:47:46PM +0530, Sudip Mukherjee wrote:
> This is an attempt to fix the build failures when building mn10300 with
> allmodconfig. As I have never worked with arch files so I hope you will
> point me to right direction to correct my mistakes in this attempt.

Why has the linux-arm-kernel mailing list been copied for something
which clearly has nothing to do with ARM?  Am I missing something
in this series?

(Or is there a competition on to see who can add as many entries in
the Cc without getting caught by any filtering? :) )

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
