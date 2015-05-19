From: Zhangfei Gao <zhangfei.gao@gmail.com>
Subject: Re: [RFC PATCH 0/4] Command Queueing Support in eMMC
Date: Tue, 19 May 2015 19:13:28 +0800
Message-ID: <CAMj5BkjrSsy+K9uVgxhsNPnVyY1u0yxHeV-NJ+L8eY_xeDf6Fg@mail.gmail.com>
References: <cover.1417519249.git.asutoshd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:33753 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628AbbESLN3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 May 2015 07:13:29 -0400
In-Reply-To: <cover.1417519249.git.asutoshd@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Asutosh Das <asutoshd@codeaurora.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-arm-msm@vger.kernel.org

Hi, Asutosh

On Tue, Dec 2, 2014 at 7:53 PM, Asutosh Das <asutoshd@codeaurora.org> wrote:
> In this patch series, we propose a method to add support for
> Command Queueing(CQ) feature added to eMMC-5.1 specification.
> This feature includes new commands for issuing tasks to the
> device and orders the execution of tasks to the device. It
> also has task management functions.
>
> The initialization of CQ is decided based on the underlying
> driver capability and the capability advertised by the card
> through ext_csd.
>
> We have selectively adopted the scsi design of pulling in
> requests from kernel block layer.
>
> In order to support queueing of multiple requests, we have
> added a new issue function to mmc-queue. This selectively
> pulls the requests and prepares and issues it to the underlying
> driver. We have used the inherent tagging mechanism of kernel
> block layer to keep track and map tags to the slots of underlying
> driver. The current design doesn't block for the request to
> complete. We have separated the issuing and completion path
> of the request and tracking is done using the tag assigned to
> the request.
>
> We have introduced a number of APIs to mmc block layer to
> facilitate servicing of requests.
>
> The completion of requests is handled in a softirq registered
> with the kernel block layer during initialization. The error
> handling however would be done using a workqueue and is under
> development.
>
> We have separated the legacy eMMC code from CQ code, so as to
> make it more manageable.
>
> A new layer has been introduced to serve the CQ compliant drivers.
> This layer (cq_hci) has all the standard functionality implemented.
> It also has necessary hooks for convenience of platform drivers.
>
> Asutosh Das (4):
>   mmc: queue: initialization of command-queue support
>   mmc: card: Add eMMC command queuing support in mmc block layer
>   mmc: cmdq: support for command queue enabled host
>   mmc: sdhci: add command queue support to sdhci
>
> Sujit Reddy Thumma (1):
>   mmc: core: Add support to read command queue parameters

Do you have any updated version of this patch set, which have been
verified on your platform?

Thanks
